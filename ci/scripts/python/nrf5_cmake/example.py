from __future__ import annotations

from enum import Enum
from typing import Any, Dict, Set, Optional
from unittest.case import TestCase
from nrf5_cmake.version import Version
from jsonschema import validate as validate_json


class ExampleProperty(Enum):
    SOURCES = "sources"
    INCLUDES = "includes"
    CFLAGS = "cflags"
    ASMFLAGS = "asmflags"
    LDFLAGS = "ldflags"


class Example:
    json_schema = {
        "type": "object",
        "required": ["path", "local_path", "sdk_version"],
        "additionalProperties": False,
        "properties": {
            "path": {
                "type": "string"
            },
            "local_path": {
                "type": "string"
            },
            "sdk_version": {
                "type": "string",
                "pattern": r"[0-9]+\.[0-9]+\.[0-9]+"
            },
            ** {
                x.value: {
                    "type": "array",
                    "items": {"type": "string"}
                } for x in ExampleProperty
            }
        }
    }

    def __init__(self,
                 path: str,
                 local_path: str,
                 sdk_version: Version,
                 sources: Optional[Set[str]] = None,
                 includes: Optional[Set[str]] = None,
                 cflags: Optional[Set[str]] = None,
                 asmflags: Optional[Set[str]] = None,
                 ldflags: Optional[Set[str]] = None):

        self._path = path
        self._local_path = local_path
        self._sdk_version = sdk_version

        self._props: Dict[ExampleProperty, Set[str]] = {}
        self._props[ExampleProperty.SOURCES] = sources or set()
        self._props[ExampleProperty.INCLUDES] = includes or set()
        self._props[ExampleProperty.CFLAGS] = cflags or set()
        self._props[ExampleProperty.ASMFLAGS] = asmflags or set()
        self._props[ExampleProperty.LDFLAGS] = ldflags or set()

    def __str__(self):
        return str(self.to_json())

    @staticmethod
    def from_json(json_value: dict) -> Example:
        validate_json(instance=json_value,
                      schema=Example.json_schema)

        example = Example(
            json_value["path"],
            json_value["local_path"],
            Version.from_string(json_value["sdk_version"]),
        )

        for prop in ExampleProperty:
            if prop.value in json_value:
                example._props[prop] = set(json_value[prop.value])
            else:
                example._props[prop] = set()

        return example

    def to_json(self) -> dict:
        json_value: Dict[str, Any] = {
            "path": self._path,
            "local_path": self._local_path,
            "sdk_version": str(self._sdk_version)
        }

        for prop in ExampleProperty:
            if len(self._props[prop]) > 0:
                json_value[prop.value] = list(self._props[prop])
                json_value[prop.value].sort()

        return json_value

    @property
    def path(self) -> str:
        return self._path

    @path.setter
    def path(self, path: str):
        self._path = path

    @property
    def local_path(self) -> str:
        return self._local_path

    @local_path.setter
    def local_path(self, local_path: str):
        self._local_path = local_path

    @property
    def sdk_version(self) -> Version:
        return self._sdk_version

    @sdk_version.setter
    def sdk_version(self, sdk_version: Version):
        self._sdk_version = sdk_version

    def get_prop(self, prop: ExampleProperty) -> Set[str]:
        return self._props[prop]

    def set_prop(self, prop: ExampleProperty, value: Set[str]):
        self._props[prop] = value


class ExampleTestCase(TestCase):
    def test_json(self):
        json_value = {
            "path": "path",
            "local_path": "local_path",
            "sdk_version": "15.3.0",
            "sources": ["s1", "s2"],
            "ldflags": ["ld1", "ld2"]
        }

        example = Example.from_json(json_value)

        self.assertEqual(example.path, "path")
        self.assertEqual(example.local_path, "local_path")
        self.assertEqual(example.sdk_version, Version(15, 3, 0))
        self.assertEqual(
            example.get_prop(ExampleProperty.SOURCES),
            {"s1", "s2"}
        )
        self.assertEqual(
            example.get_prop(ExampleProperty.LDFLAGS),
            {"ld1", "ld2"}
        )
        self.assertEqual(json_value, example.to_json())
