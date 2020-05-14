from __future__ import annotations

from enum import Enum
from nrf5_cmake.property import Access
from nrf5_cmake.version import Version
from typing import Optional
from unittest.case import TestCase
from nrf5_cmake.library_version import LibraryVersion
from nrf5_cmake.library import Library, LibraryProperty
from jsonschema import validate as validate_json


class LibraryOperation(Enum):
    ADD = "add"
    REMOVE = "remove"


class LibraryPatch:

    json_schema = {
        "type": "object",
        "additionalProperties": False,
        "required": ["operation"],
        "properties": {
            "operation": {
                "type": "string",
                "enum": [x.value for x in LibraryOperation]
            },
            "sdk_version": LibraryVersion.json_schema,
            ** Library.props_json_schema
        }
    }

    def __init__(self,
                 operation: LibraryOperation,
                 sdk_version: Optional[LibraryVersion] = None,
                 library: Optional[Library] = None):
        self._operation = operation
        self._sdk_version: Optional[LibraryVersion] = sdk_version
        self._library: Library = library or Library()

    @staticmethod
    def from_json(json_value: dict) -> LibraryPatch:
        validate_json(instance=json_value,
                      schema=LibraryPatch.json_schema)

        patch = LibraryPatch(LibraryOperation(json_value["operation"]))
        patch._library = Library.from_json(json_value)

        if "sdk_version" in json_value:
            patch._sdk_version = LibraryVersion.from_json(
                json_value["sdk_version"]
            )

        return patch

    def to_json(self) -> dict:
        json_value = {
            "operation": self._operation.value,
            **self._library.to_json()
        }

        if self._sdk_version != None:
            json_value["sdk_version"] = self._sdk_version.to_json()

        return json_value

    def __str__(self):
        return str(self.to_json())

    @property
    def operation(self) -> LibraryOperation:
        return self._operation

    @operation.setter
    def operation(self, operation: LibraryOperation):
        self._operation = operation

    @property
    def sdk_version(self) -> Optional[LibraryVersion]:
        return self._sdk_version

    @sdk_version.setter
    def sdk_version(self, sdk_version: Optional[LibraryVersion]):
        self._sdk_version = sdk_version

    @property
    def library(self):
        return self._library

    @library.setter
    def library(self, library: Library):
        self._library = library


class LibraryPatchTestCase(TestCase):
    def test_json(self):
        json_value = {
            "operation": "remove",
            "sdk_version": {
                "from": "15.0.0",
                "to": "16.0.0"
            },
            "sources": ['s1', 's2'],
            "includes": {
                "public": ["inc1"]
            }
        }

        patch = LibraryPatch.from_json(json_value)

        self.assertEqual(patch.operation, LibraryOperation.REMOVE)
        self.assertEqual(
            patch.sdk_version,
            LibraryVersion(from_version=Version(15, 0, 0),
                           to_version=Version(16, 0, 0))
        )
        self.assertEqual(
            patch.library.sources,
            {'s1', 's2'}
        )
        self.assertEqual(
            patch.library.get_prop(LibraryProperty.INCLUDES)
                         .get_items(Access.PUBLIC),
            {'inc1'}
        )

        self.assertEqual(json_value, patch.to_json())
