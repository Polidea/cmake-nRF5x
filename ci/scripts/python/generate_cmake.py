#!/usr/bin/env python3

import argparse
from pathlib import Path
from nrf5_cmake.library import Library
from nrf5_cmake.version import Version

from typing import Dict, List, Optional
from jinja2 import FileSystemLoader, Environment
from nrf5_cmake.library_description import LibraryDescription, LibraryVariant
from nrf5_cmake.library_operations import libraries_load_from_file


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
parser.add_argument("--input", required=True)
parser.add_argument("--supported_sdks", required=True, nargs="+")
parser.add_argument("--output", required=True)
parser.add_argument("--template", required=True)
args = parser.parse_args()

input_filepath: str = args.input
output_filepath: str = args.output
template_filepath: str = args.template
supported_sdks: str = args.supported_sdks

# Get list of supported SKDs for generation
sdk_list = [Version.from_string(sdk) for sdk in supported_sdks]

# Load libraries and process them. Result is a JSON file containing libraries.
libraries = libraries_load_from_file(input_filepath)
cmake_libraries = [
    process_library_description(lib[0], lib[1], sdk_list) for lib in libraries.items()
    if is_library_description_ok(lib[1], sdk_list)
]

# Check if there is a need to generate file.
if len(cmake_libraries) == 0:
    print("Skipping " + input_filepath + "... No definitions.")
    exit(0)

# Render with provided template
with open(template_filepath, 'r') as template_file, open(output_filepath, 'w') as output_file:
    template = Environment(
        loader=FileSystemLoader(Path(template_filepath).resolve().parent)
    ).from_string(template_file.read())
    output_file.write(template.render(libraries=cmake_libraries))
