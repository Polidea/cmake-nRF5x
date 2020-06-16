from __future__ import annotations

import json
from unittest import TestCase

from nrf5_cmake.library import Library, LibraryProperty, Property
from nrf5_cmake.library_description import LibraryDescription, LibraryVariant, LibraryPatch, LibraryOperation, LibraryVersion
from nrf5_cmake.version import Version
from typing import Any, Dict, List, Set, Tuple


def libraries_load_from_file(filepath: str) -> Dict[str, LibraryDescription]:
    libs: Dict[str, LibraryDescription] = {}
    with open(filepath, 'r') as file:
        json_libs: Dict[str, Any] = json.load(file)

        if not isinstance(json_libs, dict):
            raise Exception("Exampected a dictionary of libraries")

        for json_lib_name in json_libs:
            json_lib = json_libs[json_lib_name]
            libs[json_lib_name] = LibraryDescription.from_json(json_lib)

    return libs


def libraries_save_to_file(filepath: str, libraries: Dict[str, LibraryDescription]):
    json_libs: Dict[str, Any] = {}

    with open(filepath, 'w') as file:
        for lib_name, lib in libraries.items():
            json_libs[lib_name] = lib.to_json()

        json.dump(json_libs, file, indent=2)


def libraries_dependencies_per_sdk(selected_libraries: Dict[str, LibraryDescription],
                                   all_libraries: Dict[str, LibraryDescription],
                                   supported_sdks: List[Version]) -> Dict[Version, Set[str]]:

    # Collect a list of dependencies for each SDK version.
    sdk_dependencies: Dict[Version, Set[str]] = {}
    for sdk_version in supported_sdks:

        # Get list of all dependencies including libraries
        dependencies: Set[str] = set()
        for (library_name, library_desc) in selected_libraries.items():
            library_for_sdk = library_desc.library_for_sdk_version(sdk_version)
            if library_for_sdk == None:
                continue

            dependencies.add(library_name)
            dependencies.update(library_for_sdk.get_prop(
                LibraryProperty.DEPENDENCIES
            ).get_all_items())

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
                library_dep = library_dep_desc.library_for_sdk_version(
                    sdk_version)

                if library_dep == None:
                    print(
                        f"WARNING: dependency {dependency} should exist for SDK {sdk_version}")
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

    return sdk_dependencies


class LibrariesDependenciesPerSdkTestCase(TestCase):
    def test_dependencies(self):

        sdk_14 = Version.from_string("14.0.0")
        sdk_15 = Version.from_string("15.0.0")
        sdk_16 = Version.from_string("16.0.0")

        library_a = LibraryDescription(
            variant=LibraryVariant.OBJECT,
            library=Library(
                dependencies=Property(public={"b"})
            ),
            sdk_version=LibraryVersion(sdk_15),
            patches=[
                LibraryPatch(
                    operation=LibraryOperation.ADD,
                    sdk_version=LibraryVersion(sdk_15),
                    library=Library(dependencies=Property(public={"c"}))
                ),
                LibraryPatch(
                    operation=LibraryOperation.REMOVE,
                    sdk_version=LibraryVersion(sdk_16),
                    library=Library(dependencies=Property(public={"c"}))
                ),
                LibraryPatch(
                    operation=LibraryOperation.ADD,
                    sdk_version=LibraryVersion(sdk_16),
                    library=Library(dependencies=Property(public={"d"}))
                ),
            ]
        )

        library_b = LibraryDescription(
            variant=LibraryVariant.OBJECT,
        )

        library_c = LibraryDescription(
            variant=LibraryVariant.OBJECT
        )

        library_d = LibraryDescription(
            variant=LibraryVariant.OBJECT,
            library=Library(dependencies=Property(public={"e"}))
        )

        library_e = LibraryDescription(
            variant=LibraryVariant.OBJECT
        )

        library_f = LibraryDescription(
            variant=LibraryVariant.OBJECT
        )

        all_libraries = {
            "a": library_a,
            "b": library_b,
            "c": library_c,
            "d": library_d,
            "e": library_e,
            "f": library_f
        }

        supported_sdks = [
            sdk_14,
            sdk_15,
            sdk_16
        ]

        result = libraries_dependencies_per_sdk(
            {"a": library_a},
            all_libraries,
            supported_sdks
        )

        self.assertEqual(result[sdk_14], set())
        self.assertEqual(result[sdk_15], {"a", "b", "c"})
        self.assertEqual(result[sdk_16], {"a", "b", "d", "e"})
