from __future__ import annotations
from nrf5_cmake.version import Version
from nrf5_cmake.library_version import LibraryVersion

from unittest import TestCase
from enum import Enum
from nrf5_cmake.library import Library
from nrf5_cmake.library_patch import LibraryOperation, LibraryPatch
from jsonschema import validate as validate_json
from typing import List, Optional


class LibraryVariant(Enum):
    BUILTIN = "builtin"
    OBJECT = "object"
    INTERFACE = "interface"


class LibraryDescription:

    json_schema = {
        "type": "object",
        "additionalProperties": False,
        "required": ["variant"],
        "properties": {
            **Library.props_json_schema,
            **{
                "variant": {
                    "type": "string",
                    "enum": [x.value for x in LibraryVariant]
                },
                "sdk_version": LibraryVersion.json_schema,
                "documentation": {
                    "type": "string"
                },
                "patches": {
                    "type": "array",
                    "items": LibraryPatch.json_schema
                }
            }
        }
    }

    def __init__(self,
                 variant: LibraryVariant = LibraryVariant.OBJECT,
                 documentation: str = "",
                 sdk_version: Optional[LibraryVersion] = None,
                 library: Optional[Library] = None,
                 patches: Optional[List[LibraryPatch]] = None):
        self._variant = variant
        self._documentation = documentation
        self._sdk_version = sdk_version
        self._library: Library = library or Library()
        self._patches: List[LibraryPatch] = patches or []

    def __str__(self):
        return str(self.to_json())

    @staticmethod
    def from_json(json_value: dict) -> LibraryDescription:
        validate_json(instance=json_value,
                      schema=LibraryDescription.json_schema)

        library = LibraryDescription()

        if "sdk_version" in json_value:
            library._sdk_version = LibraryVersion.from_json(
                json_value["sdk_version"])

        if "documentation" in json_value:
            library._documentation = json_value["documentation"]

        if "variant" in json_value:
            library._variant = LibraryVariant(json_value["variant"])

        library._library = Library.from_json(json_value)

        if "patches" in json_value:
            for patch in json_value["patches"]:
                library._patches.append(LibraryPatch.from_json(patch))

        return library

    def to_json(self) -> dict:
        json_value = {}

        if self._sdk_version:
            json_value["sdk_version"] = self._sdk_version.to_json()

        if self._documentation:
            json_value["documentation"] = self._documentation

        if self._variant:
            json_value["variant"] = self._variant.value

        if len(self._patches) != 0:
            json_patches = []
            for patch in self._patches:
                patch_json_value = patch.to_json()
                json_patches.append(patch_json_value)
            json_value["patches"] = json_patches

        json_library = self._library.to_json()
        return {
            **json_value,
            **json_library
        }

    @property
    def variant(self) -> LibraryVariant:
        return self._variant

    @variant.setter
    def variant(self, variant: LibraryVariant):
        self._variant = variant

    @property
    def sdk_version(self) -> Optional[LibraryVersion]:
        return self._sdk_version

    @sdk_version.setter
    def sdk_version(self, sdk_version: LibraryVersion):
        self._sdk_version = sdk_version

    @property
    def documentation(self) -> str:
        return self._documentation

    @documentation.setter
    def documentation(self, documentation: str):
        self._documentation = documentation

    @property
    def library(self) -> Library:
        return self._library

    @library.setter
    def library(self, library: Library):
        self._library = library

    @property
    def patches(self) -> List[LibraryPatch]:
        return self._patches

    @patches.setter
    def patches(self, patches: List[LibraryPatch]):
        self._patches = patches

    def applies_to_sdk_version(self, version: Version) -> bool:
        return not self.sdk_version or self.sdk_version.applies_to(version)

    def library_for_sdk_version(self, version: Version) -> Optional[Library]:
        if not self.applies_to_sdk_version(version):
            return None

        result_library = Library()
        result_library.union_update(self.library)

        for patch in self.patches:
            if not patch.sdk_version.applies_to(version):
                continue

            if patch.operation == LibraryOperation.ADD:
                result_library.union_update(patch.library)
            else:
                result_library.difference_update(patch.library)

        return result_library


class LibraryTestCase(TestCase):
    def test_json(self):
        json_value = {
            "variant": "object",
            "documentation": "This is a simple object library",
            "sources": ["s1", "s2"],
            "sdk_version": {"from": "15.3.0"},
            "dependencies": {
                "private": ["prv_dep1"],
                "public": ["pub_dep1"]
            },
            "includes": {
                "interface": ["inc1", "inc2"]
            },
            "patches": [
                {
                    "operation": "add",
                    "sdk_version": {"to": "16.0.0"},
                    "sources": ["s3", "s4"]
                }
            ]
        }

        library = LibraryDescription.from_json(json_value)

        self.assertEqual(library.variant, LibraryVariant.OBJECT)
        self.assertEqual(
            library.documentation,
            "This is a simple object library"
        )
        self.assertEqual(library.sdk_version, LibraryVersion(
            from_version=Version(15, 3, 0))
        )

        self.assertEqual(json_value, library.to_json())

    def test_library_patches(self):
        lib_desc = LibraryDescription(
            variant=LibraryVariant.OBJECT,
            documentation="",
            sdk_version=LibraryVersion(Version(15, 0, 0), Version(16, 0, 0)),
            library=Library(sources={"s1", "s2"}),
            patches=[
                LibraryPatch(
                    LibraryOperation.ADD,
                    LibraryVersion(Version(15, 1, 0)),
                    Library({"s3"})
                ),
                LibraryPatch(
                    LibraryOperation.ADD,
                    LibraryVersion(Version(15, 2, 0), Version(15, 3, 0)),
                    Library({"s4"})
                ),
                LibraryPatch(
                    LibraryOperation.REMOVE,
                    LibraryVersion(Version(15, 2, 1), Version(15, 4, 0)),
                    Library({"s1"})
                )
            ]
        )

        self.assertEqual(
            lib_desc.library_for_sdk_version(Version(14, 0, 0)),
            None
        )
        self.assertEqual(
            lib_desc.library_for_sdk_version(Version(16, 1, 0)),
            None
        )
        self.assertSetEqual(
            lib_desc.library_for_sdk_version(Version(15, 0, 2)).sources,
            {'s1', 's2'}
        )
        self.assertSetEqual(
            lib_desc.library_for_sdk_version(Version(15, 1, 2)).sources,
            {'s1', 's2', 's3'}
        )
        self.assertSetEqual(
            lib_desc.library_for_sdk_version(Version(15, 2, 0)).sources,
            {'s1', 's2', 's3', 's4'}
        )
        self.assertSetEqual(
            lib_desc.library_for_sdk_version(Version(15, 2, 2)).sources,
            {'s2', 's3', 's4'}
        )
        self.assertSetEqual(
            lib_desc.library_for_sdk_version(Version(15, 4, 0)).sources,
            {'s2', 's3'}
        )
        self.assertSetEqual(
            lib_desc.library_for_sdk_version(Version(15, 4, 1)).sources,
            {'s1', 's2', 's3'}
        )
