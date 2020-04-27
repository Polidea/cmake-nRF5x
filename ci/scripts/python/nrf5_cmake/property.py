from __future__ import annotations

from unittest import TestCase
from enum import Enum
from typing import Dict, Iterable, List, Set
from jsonschema import validate as validate_json
from jsonschema.exceptions import ValidationError


class Access(Enum):
    PUBLIC = "public"
    PRIVATE = "private"
    INTERFACE = "interface"
    ALL = "all"

    @property
    def matches(self) -> List[Access]:
        if self == Access.ALL:
            return [Access.PUBLIC, Access.PRIVATE, Access.INTERFACE]
        else:
            return [self]


class Property():

    json_schema = {
        "type": "object",
        "additionalProperties": False,
        "properties": {
            "public": {
                "type": "array",
                "items": {
                    "type": "string"
                }
            },
            "interface": {
                "type": "array",
                "items": {
                    "type": "string"
                }
            },
            "private": {
                "type": "array",
                "items": {
                    "type": "string"
                }
            }
        }
    }

    def __init__(self,
                 public: Set[str] = set(),
                 private: Set[str] = set(),
                 interface: Set[str] = set()):
        self._props: Dict[Access, Set[str]] = {
            Access.PUBLIC: public,
            Access.PRIVATE: private,
            Access.INTERFACE: interface
        }

    def __str__(self):
        return str(self.to_json())

    def __eq__(self, other):
        if not isinstance(other, Property):
            return False

        for access in Access.ALL.matches:
            if self._props[access] != other._props[access]:
                return False

        return True

    @staticmethod
    def from_json(json_value: dict):
        validate_json(instance=json_value,
                      schema=Property.json_schema)
        prop = Property()
        for access in Access.ALL.matches:
            if access.value in json_value:
                prop._props[access] = set(json_value[access.value])
        return prop

    @staticmethod
    def union(properties: Iterable[Property], access: Access) -> Property:
        result = Property()
        for access in access.matches:
            u = set.union(*[prop.get_props(access) for prop in properties])
            result._props[access] = u
        return result

    def union_update(self, property: Property, access: Access):
        for access in access.matches:
            self._props[access].update(property._props[access])

    @staticmethod
    def intersection(properties: Iterable[Property], access: Access) -> Property:
        result = Property()
        for access in access.matches:
            i = set.intersection(*[prop.get_props(access)
                                   for prop in properties])
            result._props[access] = i
        return result

    def intersection_update(self, property: Property, access: Access):
        for access in access.matches:
            self._props[access].intersection_update(property._props[access])

    def difference_update(self, property: Property, access: Access):
        for access in access.matches:
            self._props[access].difference_update(property._props[access])

    def to_json(self) -> dict:
        json_props = {}
        for access in Access.ALL.matches:
            if len(self._props[access]) != 0:
                json_item = list(self._props[access])
                json_item.sort()
                json_props[access.value] = json_item

        return json_props

    def get_props(self, access: Access) -> Set[str]:
        return set.union(*[self._props[x] for x in access.matches])

    def set_props(self, items: Set[str], access: Access):
        for access in access.matches:
            self._props[access] = items

    def add_prop(self, item: str, access: Access):
        for access in access.matches:
            self._props[access].add(item)

    def add_props(self, items: Set[str], access: Access):
        for access in access.matches:
            self._props[access].update(items)

    def remove_prop(self, item: str, access: Access):
        for access in access.matches:
            if item in self._props[access]:
                self._props[access].remove(item)

    def remove_props(self, items: Set[str], access: Access):
        for access in access.matches:
            self._props[access].difference_update(items)


class PropertyTestCase(TestCase):

    def setUp(self):
        self.example = Property.from_json({
            "public": ["A", "B", "Z"],
            "private": ["C", "D", "E", "Z"],
            "interface": ["Z"]
        })
        self.assertSetEqual(
            self.example.get_props(Access.ALL),
            {"A", "B", "Z", "C", "D", "E"}
        )
        self.assertSetEqual(
            self.example.get_props(Access.PUBLIC),
            {"A", "B", "Z"}
        )
        self.assertSetEqual(
            self.example.get_props(Access.PRIVATE),
            {"C", "D", "E", "Z"}
        )
        self.assertSetEqual(
            self.example.get_props(Access.INTERFACE),
            {"Z"}
        )

    def test_json_invalid_property(self):
        self.assertRaises(
            ValidationError,
            lambda: Property.from_json({"publi": []})
        )

    def test_private_json_only(self):
        example_private = Property.from_json({
            "private": ["A", "B"]
        })
        self.assertSetEqual(
            example_private.get_props(Access.PRIVATE),
            {"A", "B"}
        )
        self.assertSetEqual(
            example_private.get_props(Access.PUBLIC),
            set()
        )
        self.assertSetEqual(
            example_private.get_props(Access.INTERFACE),
            set()
        )
        self.assertSetEqual(
            example_private.get_props(Access.ALL),
            {"A", "B"}
        )

    def test_inline_props(self):
        props = Property(public={"A", "B", "Z"},
                         private={"C", "D", "E", "Z"},
                         interface={"Z"})

        for access in Access:
            self.assertSetEqual(
                props.get_props(access),
                self.example.get_props(access)
            )

    def test_set_props(self):
        self.example.set_props({"P1", "P2"}, Access.PUBLIC)
        self.example.set_props({"P1", "P3"}, Access.PRIVATE)
        self.example.set_props({"I1", "I2"}, Access.INTERFACE)

        self.assertSetEqual(
            self.example.get_props(Access.PUBLIC),
            {"P1", "P2"}
        )
        self.assertSetEqual(
            self.example.get_props(Access.PRIVATE),
            {"P1", "P3"}
        )
        self.assertSetEqual(
            self.example.get_props(Access.INTERFACE),
            {"I1", "I2"}
        )

    def test_add_prop(self):
        self.example.add_prop("P3", Access.PUBLIC)
        self.example.add_prop("P4", Access.PRIVATE)
        self.example.add_prop("I3", Access.INTERFACE)

        self.assertSetEqual(
            self.example.get_props(Access.PUBLIC),
            {"A", "B", "Z", "P3"}
        )
        self.assertSetEqual(
            self.example.get_props(Access.PRIVATE),
            {"C", "D", "E", "Z", "P4"}
        )
        self.assertSetEqual(
            self.example.get_props(Access.INTERFACE),
            {"Z", "I3"}
        )

    def test_add_props(self):
        self.example.add_props({"B", "P4"}, Access.PUBLIC)
        self.example.add_props(set(), Access.PRIVATE)
        self.example.add_props({"I1", "I2"}, Access.INTERFACE)

        self.assertSetEqual(
            self.example.get_props(Access.PUBLIC),
            {"A", "B", "Z", "P4"}
        )
        self.assertSetEqual(
            self.example.get_props(Access.PRIVATE),
            {"C", "D", "E", "Z"}
        )
        self.assertSetEqual(
            self.example.get_props(Access.INTERFACE),
            {"Z", "I1", "I2"}
        )

    def test_remove_prop(self):
        self.example.remove_prop("Z", Access.PUBLIC)
        self.example.remove_prop("P4", Access.PRIVATE)
        self.example.remove_prop("Z", Access.INTERFACE)

        self.assertSetEqual(
            self.example.get_props(Access.PUBLIC),
            {"A", "B"}
        )
        self.assertSetEqual(
            self.example.get_props(Access.PRIVATE),
            {"C", "D", "E", "Z"}
        )
        self.assertSetEqual(
            self.example.get_props(Access.INTERFACE),
            set()
        )

    def test_remove_props(self):
        self.example.remove_props(set(["A", "B"]), Access.PUBLIC)
        self.example.remove_props(set(), Access.PRIVATE)
        self.example.remove_props(set(["Z", "Y"]), Access.INTERFACE)

        self.assertSetEqual(
            self.example.get_props(Access.PUBLIC),
            {"Z"}
        )
        self.assertSetEqual(
            self.example.get_props(Access.PRIVATE),
            {"C", "D", "E", "Z"}
        )
        self.assertSetEqual(
            self.example.get_props(Access.INTERFACE),
            set()
        )

    def test_union(self):
        prop1 = Property.from_json({
            "public": ["A", "B", "C"],
            "private": ["PA", "PB"],
            "interface": ["I1", "I2"]
        })

        prop2 = Property.from_json({
            "public": ["D"],
            "private": ["PA", "PC"],
            "interface": ["I1", "I2"]
        })

        union = Property.union([prop1, prop2], Access.ALL)
        self.assertSetEqual(
            union.get_props(Access.PUBLIC),
            {"A", "B", "C", "D"}
        )
        self.assertSetEqual(
            union.get_props(Access.PRIVATE),
            {"PA", "PB", "PC"}
        )
        self.assertSetEqual(
            union.get_props(Access.INTERFACE),
            {"I1", "I2"}
        )

    def test_intersection(self):
        prop1 = Property.from_json({
            "public": ["A", "B", "C"],
            "private": ["PA", "PB"],
            "interface": ["I1", "I2"]
        })

        prop2 = Property.from_json({
            "public": ["D"],
            "private": ["PA", "PC"],
            "interface": ["I1", "I2"]
        })

        intersection = Property.intersection([prop1, prop2], Access.ALL)
        self.assertSetEqual(
            intersection.get_props(Access.PUBLIC),
            set()
        )
        self.assertSetEqual(
            intersection.get_props(Access.PRIVATE),
            {"PA"}
        )
        self.assertSetEqual(
            intersection.get_props(Access.INTERFACE),
            {"I1", "I2"}
        )

    def test_union_update(self):
        prop = Property.from_json({
            "public": ["C"],
            "private": ["B", "C", "D"],
            "interface": ["Z"]
        })

        self.example.union_update(prop, Access.ALL)
        self.assertSetEqual(
            self.example.get_props(Access.PUBLIC),
            {"A", "B", "Z", "C"}
        )
        self.assertSetEqual(
            self.example.get_props(Access.PRIVATE),
            {"E", "Z", "C", "D", "B"}
        )
        self.assertSetEqual(
            self.example.get_props(Access.INTERFACE),
            {"Z"}
        )

    def test_intersection_update(self):
        prop = Property.from_json({
            "public": ["C"],
            "private": ["B", "C", "D"],
            "interface": ["Z"]
        })

        self.example.intersection_update(prop, Access.ALL)
        self.assertSetEqual(
            self.example.get_props(Access.PUBLIC),
            set()
        )
        self.assertSetEqual(
            self.example.get_props(Access.PRIVATE),
            {"C", "D"}
        )
        self.assertSetEqual(
            self.example.get_props(Access.INTERFACE),
            {"Z"}
        )

    def test_difference_update(self):
        prop = Property.from_json({
            "public": ["C"],
            "private": ["B", "C", "D"],
            "interface": ["Z"]
        })

        self.example.difference_update(prop, Access.ALL)
        self.assertSetEqual(
            self.example.get_props(Access.PUBLIC),
            {"A", "B", "Z"}
        )
        self.assertSetEqual(
            self.example.get_props(Access.PRIVATE),
            {"E", "Z"}
        )
        self.assertSetEqual(
            self.example.get_props(Access.INTERFACE),
            set()
        )
