from __future__ import annotations
from nrf5_cmake.library_version import LibraryVersion

from unittest import TestCase
from enum import Enum
from nrf5_cmake.library_properties import LibraryProperties, LibraryProperyName as PN
from nrf5_cmake.library_patch import LibraryPatch
from jsonschema import validate as validate_json
from typing import List, Optional


class LibraryType(Enum):
    BUILTIN = "builtin"
    OBJECT = "object"
    INTERFACE = "interface"


class Library:

    json_schema = {
        "type": "object",
        "additionalProperties": False,
        "required": ["type"],
        "properties": {
            **LibraryProperties.props_json_schema,
            **{
                "sdk_version": LibraryVersion.json_schema,
                "documentation": {
                    "type": "string"
                },
                "type": {
                    "type": "string",
                    "enum": [x.value for x in LibraryType]
                },
                "patches": {
                    "type": "array",
                    "items": LibraryPatch.json_schema
                }
            }
        }
    }

    def __init__(self,
                 sdk_version: Optional[LibraryVersion] = None,
                 props: LibraryProperties = LibraryProperties(),
                 documentation: str = "",
                 type: LibraryType = LibraryType.OBJECT,
                 patches: List[LibraryPatch] = []):
        self._props = props
        self._sdk_version = sdk_version
        self._documentation = documentation
        self._type = type
        self._patches = patches

    def __str__(self):
        return str(self.to_json())

    @staticmethod
    def from_json(json_value: dict) -> Library:
        validate_json(instance=json_value,
                      schema=Library.json_schema)

        library = Library()

        if "sdk_version" in json_value:
            library._sdk_version = LibraryVersion.from_json(
                json_value["sdk_version"])

        if "documentation" in json_value:
            library._documentation = json_value["documentation"]

        if "type" in json_value:
            library._type = LibraryType(json_value["type"])

        library._props = LibraryProperties.from_json(json_value)

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

        if self._type:
            json_value["type"] = self._type.value

        if len(self._patches) != 0:
            json_patches = []
            for patch in self._patches:
                patch_json_value = patch.to_json()
                json_patches.append(patch_json_value)
            json_value["patches"] = json_patches

        json_props = self._props.to_json()
        return {
            **json_value,
            **json_props
        }


class LibraryTestCase(TestCase):
    def test_json(self):
        json_value = {
            "type": "object",
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

        library = Library.from_json(json_value)
        self.assertEqual(json_value, library.to_json())
