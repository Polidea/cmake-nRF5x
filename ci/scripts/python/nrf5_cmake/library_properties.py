from __future__ import annotations

from unittest import TestCase
from enum import Enum
from typing import Dict, Optional, Set
from jsonschema import validate as validate_json

from nrf5_cmake.property import Access, Property
from nrf5_cmake.version import Version


class LibraryProperyName(Enum):
    DEPENDENCIES = "dependencies"
    INCLUDES = "includes"
    CFLAGS = "cflags"
    ASMFLAGS = "asmflags"
    LDFLAGS = "ldflags"


class LibraryProperties:

    props_json_schema = {
        "sources": {
            "type": "array",
            "items": {
                "type": "string"
            }
        },
        "dependencies": Property.json_schema,
        "includes": Property.json_schema,
        "cflags": Property.json_schema,
        "asmflags": Property.json_schema,
        "ldflags": Property.json_schema,
    }

    json_schema = {
        "type": "object",
        "properties": props_json_schema
    }

    def __init__(self):
        self._sources: Set[str] = set()
        self._props: Dict[LibraryProperyName, Property] = {}

        for prop_name in LibraryProperyName:
            self._props[prop_name] = Property()

    def __str__(self):
        return str(self.to_json())

    @staticmethod
    def from_json(json_value: dict) -> LibraryProperties:
        validate_json(instance=json_value,
                      schema=LibraryProperties.json_schema)

        library_props = LibraryProperties()
        if "sources" in json_value:
            library_props._sources = set(json_value["sources"])

        for property_name in LibraryProperyName:
            if property_name.value in json_value:
                library_props._props[property_name] = Property.from_json(
                    json_value[property_name.value]
                )

        return library_props

    def to_json(self) -> dict:
        json_value = {}

        if len(self._sources) != 0:
            sources_json = list(self._sources)
            sources_json.sort()
            json_value["sources"] = sources_json

        for property_name in LibraryProperyName:
            if len(self._props[property_name].get_props(Access.ALL)) == 0:
                continue
            prop_json = self._props[property_name].to_json()
            json_value[property_name.value] = prop_json

        return json_value

    @property
    def sources(self) -> Set[str]:
        return self._sources

    @sources.setter
    def sources(self, sources: Set[str]):
        self._sources = sources

    def get(self, property_name: LibraryProperyName) -> Property:
        return self._props[property_name]

    def set(self, property_name: LibraryProperyName, prop: Property):
        self._props[property_name] = prop


class LibraryPropertiesTestCase(TestCase):
    def test_json(self):
        json_value = {
            "sources": ["s1", "s2"],
            "dependencies": {
                "private": ["dep1", "dep2"]
            },
            "includes": {
                "public": ["inc1"]
            },
            "cflags": {
                "interface": ["int1"]
            },
            "asmflags": {
                "public": ["asm1"]
            },
            "ldflags": {
                "public": ["ld1"]
            }
        }

        value = LibraryProperties.from_json(json_value)
        self.assertSetEqual(value.sources, {"s1", "s2"})

        LP = LibraryProperyName
        self.assertEqual(
            value.get(LP.DEPENDENCIES),
            Property(private={"dep1", "dep2"})
        )
        self.assertEqual(
            value.get(LP.INCLUDES),
            Property(public={"inc1"})
        )
        self.assertEqual(
            value.get(LP.CFLAGS),
            Property(interface={"int1"})
        )
        self.assertEqual(
            value.get(LP.ASMFLAGS),
            Property(public={"asm1"})
        )
        self.assertEqual(
            value.get(LP.LDFLAGS),
            Property(public={"ld1"})
        )

        self.assertEqual(json_value, value.to_json())
