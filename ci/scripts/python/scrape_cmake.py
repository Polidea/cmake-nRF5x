#!/usr/bin/env python3

import sys
import re
import json
import argparse

from module_structure import module_create
from module_operations import modules_save_to_file


def process_cmake(file_path, modules):
    """Process CMake file and collect modules

    Arguments:
        file_path {Filepath} -- Filepath to CMake files describing modules
        modules {Modules} -- List of modules where new module should be added.
    """
    with open(file_path, 'r') as file:
        content = "".join(file.readlines())

        # Create a dict of modules.
        new_modules = {}

        # Search for all libraries and add them to modules
        library_names = re.findall(
            r"(?:\#(.*))?\s*add_library\((\S+)\s*(\S+)\s*(?:EXCLUDE_FROM_ALL)?((?:\s*\"\S+\")*)\s*\)", content)
        for (documentation, library_name, library_type, library_sources) in library_names:

            # Check library type
            if not library_type in ["OBJECT", "INTERFACE"]:
                print("Library not handled: " + library_name +
                      " with type: " + library_type)
                continue

            # Create a new module
            new_module = module_create()
            new_module["type"] = library_type.lower()

            # Add sources if are relative to nRF SDK path.
            library_sources = library_sources.split()
            for library_source in library_sources:
                library_source = library_source.strip("\"")
                prefix = "${NRF5_SDK_PATH}/"
                if library_source.startswith(prefix):
                    new_module["sources"].add(library_source[len(prefix):])

            # Add module
            if documentation != None:
                new_module["documentation"] = documentation.strip()
            new_modules[library_name] = new_module

        # Search for new include flags
        library_includes = re.findall(
            r"target_include_directories\((\S+)\s*(\S+)((?:\s+\"\S+\")+)\s*\)", content)
        for (library_name, access_modifier, includes) in library_includes:

            # Ignore invalid access modifiers
            if not access_modifier in ["PUBLIC", "INTERFACE", "PRIVATE"]:
                print("WARNING: Unknown access modifier: " + access_modifier)
                continue

            # Ignore not registered libraries
            if not library_name in new_modules:
                print("WARNING: Library not found: " + library_name)
                continue

            # Add include paths to known module
            includes = includes.split()
            for include in includes:
                include = include.strip("\"").strip("/")
                prefix = "${NRF5_SDK_PATH}/"
                if include.startswith(prefix):
                    new_modules[library_name]["includes"][access_modifier.lower()].add(
                        include[len(prefix):])

        # Search for dependencies
        library_dependencies = re.findall(
            r"target_link_libraries\((\w+)\s*(\w+)\s*((?:\w\s*)+)\)", content)
        for (library_name, access_modifier, dependencies) in library_dependencies:

            # Ignore invalid access modifiers
            if not access_modifier in ["PUBLIC", "INTERFACE", "PRIVATE"]:
                print("WARNING: Unknown access modifier: " + access_modifier + " for " + library_name)
                continue

            # Ignore not registered libraries
            if not library_name in new_modules:
                print("WARNING: Library not found: " + library_name)
                continue

             # Add dependencies to known module
            dependencies = dependencies.split()
            for dependency in dependencies:
                dependency = dependency.strip()
                new_modules[library_name]["dependencies"][access_modifier.lower()].add(
                    dependency)

        # Add new modules
        for new_module_name in new_modules:
            modules[new_module_name] = new_modules[new_module_name]


# Parse arguments
parser = argparse.ArgumentParser()
parser.add_argument("--output")
args = parser.parse_args()

# Scrape modules
modules = {}
for line in sys.stdin.readlines():
    paths = line.split(" ")
    for path in paths:
        file_path = path.strip()
        if file_path != '':
            process_cmake(file_path, modules)

# Save them to a file
modules_save_to_file(args.output, modules)
