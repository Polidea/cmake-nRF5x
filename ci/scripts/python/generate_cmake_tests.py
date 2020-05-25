#!/usr/bin/env python3

import os
import argparse

from pathlib import Path
from nrf5_cmake.library import Library, LibraryProperty
from nrf5_cmake.version import Version

from typing import Dict, List, Optional, Set
from jinja2 import FileSystemLoader, Environment
from nrf5_cmake.library_description import LibraryDescription, LibraryVariant
from nrf5_cmake.library_operations import libraries_load_from_file


def generate_library_test(library_name: str, library: LibraryDescription, libraries: Dict[str, LibraryDescription], supported_sdks: List[str]):
    # Collect all dependencies
    print(library_name)

    # Collect a list of dependencies for each SDK version.
    sdk_dependencies: Dict[str, Set[str]] = {}
    for sdk_version in supported_sdks:

        # Get list of all dependencies
        version = Version.from_string(sdk_version)
        library_for_sdk = library.library_for_sdk_version(version)
        if library_for_sdk == None:
            sdk_dependencies[sdk_version] = set()
            continue

        # Get all dependencies (merge interface & private)
        dependencies = library_for_sdk.get_prop(
            LibraryProperty.DEPENDENCIES
        ).get_all_items()
        dependencies.add(library_name)

        # Iterate over all existing dependencies and collect new ones.
        # If expanded list of dependencies is bigger than original ones
        # continue.
        while True:
            new_dependencies = dependencies.copy()
            for dependency in dependencies:
                # Check if dependecy exists...
                if not dependency in all_libraries:
                    print(f"WARNING: dependency {dependency} doesn't exist")
                    continue
                library_dep_desc = all_libraries[dependency]

                # Check if dependency exists for this SDK version.
                library_dep = library_dep_desc.library_for_sdk_version(version)
                if library_dep == None:
                    print(
                        f"WARNING: dependency {dependency} should exist for SDK {version} inside {library_name}")
                    continue

                # Get all dependencies and apply them.
                library_dep_dep_list = library_dep.get_prop(
                    LibraryProperty.DEPENDENCIES
                ).get_all_items()
                new_dependencies.update(library_dep_dep_list)

            # Check if two sets are the same
            if new_dependencies == dependencies:
                break

            # Use new extended list of dependencies.
            dependencies = new_dependencies

        # Add generated dependencies to version
        sdk_dependencies[sdk_version] = dependencies

    # Generate base dependencies.
    base_dependencies = set.intersection(
        *(x[1] for x in sdk_dependencies.items())
    )

    # Custom patches
    custom_patch: bool = False
    custom_patches = {
        "nrf5_ble_lesc": {"nrf5_crypto_cc310_backend"}
    }
    if library_name in custom_patches:
        custom_patch = True
        base_dependencies.update(custom_patches[library_name])

    # Add SDK version
    sdk_version = None
    if library.sdk_version:
        sdk_version = library.sdk_version.to_json()

    # Return data used to create a library test.
    return {
        "name": library_name,
        "custom_patch": custom_patch,
        "sdk_version": sdk_version,
        "base": sorted(base_dependencies),
        "patches": {
            x[0]: sorted(set.difference(x[1], base_dependencies)) for x in sdk_dependencies.items()
        }
    }


# Parse arguments
parser = argparse.ArgumentParser()
parser.add_argument("--input_dir", required=True)
parser.add_argument("--supported_sdks", required=True, nargs="+")
parser.add_argument("--output_dir", required=True)
parser.add_argument("--template", required=True)
args = parser.parse_args()

input_dir: str = args.input_dir
output_dir: str = args.output_dir
template_filepath: str = args.template
supported_sdks: List[str] = args.supported_sdks

# Load all libraries from the JSON files contained inside input dir.
all_libraries: Dict[str, LibraryDescription] = {}

for root, dirs, files in os.walk(input_dir):
    for file in files:
        if not file.endswith(".json"):
            continue
        file_libs = libraries_load_from_file(os.path.join(root, file))
        all_libraries.update(file_libs)

# Render with provided template
template_file = open(template_filepath, 'r')
template = Environment(
    loader=FileSystemLoader(Path(template_filepath).resolve().parent)
).from_string(template_file.read())

# For each library, alphabetically create a test which creates static library
# with custom sdk_config.h file.
library_names = sorted(all_libraries.keys())

for library_name in library_names:
    # Make sure that library is of object type.
    library = all_libraries[library_name]
    if library.variant != LibraryVariant.OBJECT:
        continue

    # Make sure that test directory exists for specific library.
    test_path = Path(output_dir).resolve().joinpath(library_name)
    test_path.mkdir(parents=True, exist_ok=True)

    # Generate library test
    library_json = generate_library_test(
        library_name, library, all_libraries, supported_sdks
    )

    # Render template
    output_file = open(test_path.joinpath("CMakeLists.txt"), 'w')
    output_file.write(template.render(library=library_json))
