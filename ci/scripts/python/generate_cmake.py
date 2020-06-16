#!/usr/bin/env python3

import os
import argparse

from pathlib import Path
from nrf5_cmake.library import Library
from nrf5_cmake.version import Version

from typing import Dict, List, Optional
from jinja2 import FileSystemLoader, Environment
from nrf5_cmake.library_description import LibraryDescription, LibraryVariant
from nrf5_cmake.library_operations import libraries_load_from_file, libraries_dependencies_per_sdk


def is_library_description_ok(library: LibraryDescription, sdks: List[Version]) -> bool:
    # We ignore builtin libraries.
    if library.variant == LibraryVariant.BUILTIN:
        return False

    # Library needs to apply to at least one SDK version.
    for sdk in sdks:
        if library.applies_to_sdk_version(sdk):
            return True

    return False


def process_library_description(library_name: str,
                                library: LibraryDescription,
                                sdks: List[Version]):

    # Check if SDK version check needs to be added.
    sdk_version: Optional[dict] = None
    if library.sdk_version:
        for sdk in sdk_list:
            if not library.applies_to_sdk_version(sdk):
                sdk_version = library.sdk_version.to_json()
                break
        else:
            sdk_version = None

    # Get intersection part of the library for all SDKs (called base_library)
    def all_sdk_libraries():
        for sdk in sdk_list:
            sdk_library = library.library_for_sdk_version(sdk)
            if sdk_library:
                yield sdk_library
    base_library = Library.intersection(all_sdk_libraries())

    # Find all other libraries described as patches
    patches: Dict[str, dict] = {}
    empty_library = Library()
    for sdk in sdk_list:
        # Check if patch applies to this SDK
        sdk_library = library.library_for_sdk_version(sdk)
        if not sdk_library:
            continue

        sdk_library.difference_update(base_library)
        if sdk_library == empty_library:
            continue

        # Now that library is OK, process it
        patches[str(sdk)] = sdk_library.to_json()

    return {
        "name": library_name,
        "documentation": library.documentation,
        "sdk_version": sdk_version,
        "variant": library.variant.value.upper(),
        "base": base_library.to_json(),
        "patches": patches
    }


# Parse arguments
parser = argparse.ArgumentParser()
parser.add_argument("--input_dir", required=True)
parser.add_argument("--supported_sdks", required=True, nargs="+")
parser.add_argument("--output_dir", required=True)
parser.add_argument("--lib_template", required=True)
parser.add_argument("--group_template", required=True)
args = parser.parse_args()

input_dir: str = args.input_dir
output_dir: str = args.output_dir
lib_template: str = args.lib_template
group_template: str = args.group_template
supported_sdks: str = args.supported_sdks

# Get list of supported SKDs for generation
sdk_list = [Version.from_string(sdk) for sdk in supported_sdks]

# Get all libraries per file.
libraries_per_file: Dict[str, Dict[str, LibraryDescription]] = {}

for root, dirs, files in os.walk(input_dir):
    for file in files:
        if not file.endswith(".json"):
            continue
        file_libs = libraries_load_from_file(os.path.join(root, file))
        libraries_per_file[file] = file_libs

# Generate CMake file for each file
for (filepath, libraries) in libraries_per_file.items():
    # Select only proper CMake libraries for generation.
    cmake_libraries = [
        process_library_description(lib[0], lib[1], sdk_list) for lib in libraries.items()
        if is_library_description_ok(lib[1], sdk_list)
    ]

    # Check if there is a need to generate file.
    if len(cmake_libraries) == 0:
        print("Skipping " + filepath + "... No definitions.")
        continue

    # Render with provided template
    output_filepath = os.path.join(
        output_dir, filepath.replace('.json', '.cmake'))

    with open(lib_template, 'r') as template_file, open(output_filepath, 'w') as output_file:
        template = Environment(
            loader=FileSystemLoader(Path(lib_template).resolve().parent)
        ).from_string(template_file.read())
        output_file.write(template.render(libraries=cmake_libraries))

# Collect information about groups and included libraries.
all_libraries: Dict[str, LibraryDescription] = {}
for libraries in libraries_per_file.values():
    all_libraries.update(libraries)

groups = {}
for (lib_name, library) in all_libraries.items():
    if not library.groups:
        continue

    for group in library.groups:
        if not group in groups:
            groups[group] = set()
        groups[group].add(lib_name)

# For each group collect list of all dependencies.
rendered_groups = []
for (group_name, libraries) in groups.items():
    sdk_dependencies = libraries_dependencies_per_sdk(
        {lib_name: all_libraries[lib_name] for lib_name in libraries},
        all_libraries,
        sdk_list
    )

    base_dependencies = set.intersection(
        *(x[1] for x in sdk_dependencies.items())
    )

    rendered_groups.append({
        "name": group_name,
        "base": sorted(base_dependencies),
        "patches": {
            str(x[0]): sorted(set.difference(x[1], base_dependencies)) for x in sdk_dependencies.items()
        }
    })


# Render with provided template
output_filepath = os.path.join(
    output_dir, "nrf5_groups.cmake"
)

with open(group_template, 'r') as template_file, open(output_filepath, 'w') as output_file:
    template = Environment(
        loader=FileSystemLoader(Path(group_template).resolve().parent)
    ).from_string(template_file.read())
    output_file.write(template.render(groups=rendered_groups))
