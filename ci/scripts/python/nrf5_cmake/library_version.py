from __future__ import annotations

from typing import Optional
from unittest.case import TestCase
from nrf5_cmake.version import Version
from jsonschema import validate as validate_json


class LibraryVersion:
    json_schema = {
        "type": "object",
        "additionalProperties": False,
        "anyOf": [
            {"required": ["from"]},
            {"required": ["to"]}
        ],
        "properties": {
            "from": {
                "type": "string",
                "pattern": r"[0-9]+\.[0-9]+\.[0-9]+"
            },
            "to": {
                "type": "string",
                "pattern": r"[0-9]+\.[0-9]+\.[0-9]+"
            },
        }
    }

    def __init__(self,
                 from_version: Optional[Version] = None,
                 to_version: Optional[Version] = None):
        self._from_version = from_version
        self._to_version = to_version

    @staticmethod
    def from_json(json_value: dict) -> LibraryVersion:
        validate_json(instance=json_value,
                      schema=LibraryVersion.json_schema)
        from_version = None
        to_version = None

        if "from" in json_value:
            from_version = Version.from_string(json_value["from"])
        if "to" in json_value:
            to_version = Version.from_string(json_value["to"])

        return LibraryVersion(from_version=from_version, to_version=to_version)

    def to_json(self) -> dict:
        json_value = {}

        if self._from_version != None:
            json_value["from"] = str(self._from_version)

        if self._to_version != None:
            json_value["to"] = str(self._to_version)

        return json_value

    def __str__(self):
        return str(self.to_json())

    def __eq__(self, other: LibraryVersion) -> bool:
        if not isinstance(other, LibraryVersion):
            return False
        return self._from_version == other._from_version and self._to_version == other._to_version

    @property
    def from_version(self):
        return self._from_version

    @from_version.setter
    def from_version(self, version: Optional[Version]):
        self._from_version = version

    @property
    def to_version(self):
        return self._to_version

    @to_version.setter
    def to_version(self, version: Optional[Version]):
        self._to_version = version

    def applies_to(self, version):
        if self._from_version and version < self.from_version:
            return False

        if self._to_version and version > self._to_version:
            return False

        return True


class LibraryVersionTestCase(TestCase):
    def test_json(self):
        json_value = {
            "from": "15.3.0",
            "to": "16.0.0"
        }
        version = LibraryVersion.from_json(json_value)

        self.assertEqual(version.from_version, Version(15, 3, 0))
        self.assertEqual(version.to_version, Version(16, 0, 0))
        self.assertEqual(json_value, version.to_json())

    def test_applies_to(self):
        version_range = LibraryVersion(Version(15, 3, 0), Version(16, 0, 0))

        self.assertTrue(version_range.applies_to(Version(15, 3, 0)))
        self.assertTrue(version_range.applies_to(Version(15, 4, 0)))
        self.assertTrue(version_range.applies_to(Version(15, 4, 9)))
        self.assertTrue(version_range.applies_to(Version(16, 0, 0)))

        self.assertFalse(version_range.applies_to(Version(15, 2, 0)))
        self.assertFalse(version_range.applies_to(Version(14, 3, 0)))
        self.assertFalse(version_range.applies_to(Version(16, 1, 0)))
        self.assertFalse(version_range.applies_to(Version(16, 0, 1)))
