#!/usr/bin/env python3

import sys
import re
import argparse

from typing import Dict
from nrf5_cmake.library import LibraryProperty
from nrf5_cmake.property import Access
from nrf5_cmake.library_description import LibraryDescription, LibraryVariant
from nrf5_cmake.library_operations import libraries_save_to_file


def process_library(file_path: str,
                    library_descriptions: Dict[str, LibraryDescription]):
    with open(file_path, 'r') as file:
        content = file.read()

        # Create a dict of libraries.
        new_lib_desc_descriptions: Dict[str, LibraryDescription] = {}

        # Search for all libraries and add them.
        library_names = re.findall(
            r"(?:\#(.*))?\s*add_library\((\S+)\s*(\S+)\s*(?:EXCLUDE_FROM_ALL)?((?:\s*\"\S+\")*)\s*\)", content)
        for (documentation, library_name, library_type, library_sources) in library_names:

            # Check library type
            if not library_type in ["OBJECT", "INTERFACE"]:
                print("Library not handled: " + library_name +
                      " with type: " + library_type)
                continue

            # Create a new library
            new_lib_desc = LibraryDescription(
                variant=LibraryVariant(library_type.lower())
            )

            # Add sources if are relative to nRF SDK path.
            library_sources = library_sources.split()
            for library_source in library_sources:
                library_source = library_source.strip("\"")
                prefix = "${NRF5_SDK_PATH}/"
                if library_source.startswith(prefix):
                    new_lib_desc.library.sources.add(
                        library_source[len(prefix):]
                    )

            # Add library
            if documentation != None:
                new_lib_desc.documentation = documentation.strip()
            new_lib_desc_descriptions[library_name] = new_lib_desc

        # Search for new include flags
        library_includes = re.findall(
            r"target_include_directories\((\S+)\s*(\S+)((?:\s+\"\S+\")+)\s*\)", content)
        for (library_name, access_modifier, includes) in library_includes:

            # Ignore invalid access modifiers
            if not access_modifier in ["PUBLIC", "INTERFACE", "PRIVATE"]:
                print("WARNING: Unknown access modifier: " + access_modifier)
                continue

            # Ignore not registered libraries
            if not library_name in new_lib_desc_descriptions:
                print("WARNING: Library not found: " + library_name)
                continue

            # Add include paths to known library
            includes = includes.split()
            for include in includes:
                include = include.strip("\"").strip("/")
                prefix = "${NRF5_SDK_PATH}/"
                if include.startswith(prefix):
                    lib_desc = new_lib_desc_descriptions[library_name]
                    lib_desc.library.get_prop(
                        LibraryProperty.INCLUDES
                    ).add_item(
                        include[len(prefix):],
                        Access(access_modifier.lower())
                    )

        # Search for dependencies
        library_dependencies = re.findall(
            r"target_link_libraries\((\w+)\s*(\w+)\s*((?:\w\s*)+)\)", content)
        for (library_name, access_modifier, dependencies) in library_dependencies:

            # Ignore invalid access modifiers
            if not access_modifier in ["PUBLIC", "INTERFACE", "PRIVATE"]:
                print("WARNING: Unknown access modifier: " +
                      access_modifier + " for " + library_name)
                continue

            # Ignore not registered libraries
            if not library_name in new_lib_desc_descriptions:
                print("WARNING: Library not found: " + library_name)
                continue

             # Add dependencies to known library
            dependencies = dependencies.split()
            for dependency in dependencies:
                dependency = dependency.strip()
                lib_desc = new_lib_desc_descriptions[library_name]
                lib_desc.library.get_prop(
                    LibraryProperty.DEPENDENCIES
                ).add_item(
                    dependency,
                    Access(access_modifier.lower())
                )

        # Add new libraries
        for name, lib in new_lib_desc_descriptions.items():
            library_descriptions[name] = lib


# Parse arguments
parser = argparse.ArgumentParser()
parser.add_argument("--output")
args = parser.parse_args()

# Scrape libraries
libraries: Dict[str, LibraryDescription] = {}
for line in sys.stdin.readlines():
    paths = line.split(" ")
    for path in paths:
        file_path = path.strip()
        if file_path != '':
            process_library(file_path, libraries)

# Save them to a file
libraries_save_to_file(args.output, libraries)
