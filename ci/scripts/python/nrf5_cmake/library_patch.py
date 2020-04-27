from __future__ import annotations

from enum import Enum
from nrf5_cmake.property import Access
from nrf5_cmake.version import Version
from typing import Optional
from unittest.case import TestCase
from nrf5_cmake.library_version import LibraryVersion
from nrf5_cmake.library_properties import LibraryProperties, LibraryProperyName
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
            ** LibraryProperties.props_json_schema
        }
    }

    def __init__(self,
                 operation: LibraryOperation,
                 sdk_version: Optional[LibraryVersion] = None,
                 props: LibraryProperties = LibraryProperties()):
        self._operation = operation
        self._sdk_version = sdk_version
        self._props = props

    @staticmethod
    def from_json(json_value: dict) -> LibraryPatch:
        validate_json(instance=json_value,
                      schema=LibraryPatch.json_schema)

        sdk_version = None
        if "sdk_version" in json_value:
            sdk_version = LibraryVersion.from_json(json_value["sdk_version"])

        operation = LibraryOperation(json_value["operation"])
        props = LibraryProperties.from_json(json_value)

        return LibraryPatch(operation, sdk_version, props)

    def to_json(self) -> dict:
        json_value = {
            "operation": self._operation.value,
            **self._props.to_json()
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
    def props(self):
        return self._props

    @props.setter
    def props(self, props: LibraryProperties):
        self._props = props


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
            patch.props.sources,
            {'s1', 's2'}
        )
        self.assertEqual(
            patch.props.get(LibraryProperyName.INCLUDES)
                       .get_props(Access.PUBLIC),
            {'inc1'}
        )

        self.assertEqual(json_value, patch.to_json())
