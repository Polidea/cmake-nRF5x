from __future__ import annotations

from unittest import TestCase
from enum import Enum
from typing import Dict, Iterable, List, Set, Optional
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


class Property:

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
                 public: Optional[Set[str]] = None,
                 private: Optional[Set[str]] = None,
                 interface: Optional[Set[str]] = None):
        self._items: Dict[Access, Set[str]] = {}
        self._items[Access.PUBLIC] = public or set()
        self._items[Access.PRIVATE] = private or set()
        self._items[Access.INTERFACE] = interface or set()

    def __str__(self):
        return str(self.to_json())

    def __eq__(self, other):
        if not isinstance(other, Property):
            return False

        for access in Access.ALL.matches:
            if self._items[access] != other._items[access]:
                return False

        return True

    @staticmethod
    def from_json(json_value: dict):
        validate_json(instance=json_value,
                      schema=Property.json_schema)
        prop = Property()
        for access in Access.ALL.matches:
            if access.value in json_value:
                prop._items[access] = set(json_value[access.value])
        return prop

    @staticmethod
    def union(properties: Iterable[Property], access: Access) -> Property:
        result = Property()
        for access in access.matches:
            u = set.union(*[prop.get_items(access) for prop in properties])
            result._items[access] = u
        return result

    def union_update(self, property: Property, access: Access):
        for access in access.matches:
            self._items[access].update(property._items[access])

    @staticmethod
    def intersection(properties: Iterable[Property], access: Access) -> Property:
        result = Property()
        for access in access.matches:
            i = set.intersection(*[prop.get_items(access)
                                   for prop in properties])
            result._items[access] = i
        return result

    def intersection_update(self, property: Property, access: Access):
        for access in access.matches:
            self._items[access].intersection_update(property._items[access])

    def difference_update(self, property: Property, access: Access):
        for access in access.matches:
            self._items[access].difference_update(property._items[access])

    def to_json(self) -> dict:
        json_items = {}
        for access in Access.ALL.matches:
            if len(self._items[access]) != 0:
                json_item = list(self._items[access])
                json_item.sort()
                json_items[access.value] = json_item

        return json_items

    def get_items(self, access: Access) -> Set[str]:
        return set.union(*[self._items[x] for x in access.matches])

    def set_items(self, items: Set[str], access: Access):
        for access in access.matches:
            self._items[access] = items

    def add_item(self, item: str, access: Access):
        for access in access.matches:
            self._items[access].add(item)

    def add_items(self, items: Set[str], access: Access):
        for access in access.matches:
            self._items[access].update(items)

    def remove_item(self, item: str, access: Access):
        for access in access.matches:
            if item in self._items[access]:
                self._items[access].remove(item)

    def remove_items(self, items: Set[str], access: Access):
        for access in access.matches:
            self._items[access].difference_update(items)


class PropertyTestCase(TestCase):

    def setUp(self):
        self.example = Property.from_json({
            "public": ["A", "B", "Z"],
            "private": ["C", "D", "E", "Z"],
            "interface": ["Z"]
        })
        self.assertSetEqual(
            self.example.get_items(Access.ALL),
            {"A", "B", "Z", "C", "D", "E"}
        )
        self.assertSetEqual(
            self.example.get_items(Access.PUBLIC),
            {"A", "B", "Z"}
        )
        self.assertSetEqual(
            self.example.get_items(Access.PRIVATE),
            {"C", "D", "E", "Z"}
        )
        self.assertSetEqual(
            self.example.get_items(Access.INTERFACE),
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
            example_private.get_items(Access.PRIVATE),
            {"A", "B"}
        )
        self.assertSetEqual(
            example_private.get_items(Access.PUBLIC),
            set()
        )
        self.assertSetEqual(
            example_private.get_items(Access.INTERFACE),
            set()
        )
        self.assertSetEqual(
            example_private.get_items(Access.ALL),
            {"A", "B"}
        )

    def test_inline_items(self):
        props = Property(public={"A", "B", "Z"},
                         private={"C", "D", "E", "Z"},
                         interface={"Z"})

        for access in Access:
            self.assertSetEqual(
                props.get_items(access),
                self.example.get_items(access)
            )

    def test_set_items(self):
        self.example.set_items({"P1", "P2"}, Access.PUBLIC)
        self.example.set_items({"P1", "P3"}, Access.PRIVATE)
        self.example.set_items({"I1", "I2"}, Access.INTERFACE)

        self.assertSetEqual(
            self.example.get_items(Access.PUBLIC),
            {"P1", "P2"}
        )
        self.assertSetEqual(
            self.example.get_items(Access.PRIVATE),
            {"P1", "P3"}
        )
        self.assertSetEqual(
            self.example.get_items(Access.INTERFACE),
            {"I1", "I2"}
        )

    def test_add_item(self):
        self.example.add_item("P3", Access.PUBLIC)
        self.example.add_item("P4", Access.PRIVATE)
        self.example.add_item("I3", Access.INTERFACE)

        self.assertSetEqual(
            self.example.get_items(Access.PUBLIC),
            {"A", "B", "Z", "P3"}
        )
        self.assertSetEqual(
            self.example.get_items(Access.PRIVATE),
            {"C", "D", "E", "Z", "P4"}
        )
        self.assertSetEqual(
            self.example.get_items(Access.INTERFACE),
            {"Z", "I3"}
        )

    def test_add_items(self):
        self.example.add_items({"B", "P4"}, Access.PUBLIC)
        self.example.add_items(set(), Access.PRIVATE)
        self.example.add_items({"I1", "I2"}, Access.INTERFACE)

        self.assertSetEqual(
            self.example.get_items(Access.PUBLIC),
            {"A", "B", "Z", "P4"}
        )
        self.assertSetEqual(
            self.example.get_items(Access.PRIVATE),
            {"C", "D", "E", "Z"}
        )
        self.assertSetEqual(
            self.example.get_items(Access.INTERFACE),
            {"Z", "I1", "I2"}
        )

    def test_remove_item(self):
        self.example.remove_item("Z", Access.PUBLIC)
        self.example.remove_item("P4", Access.PRIVATE)
        self.example.remove_item("Z", Access.INTERFACE)

        self.assertSetEqual(
            self.example.get_items(Access.PUBLIC),
            {"A", "B"}
        )
        self.assertSetEqual(
            self.example.get_items(Access.PRIVATE),
            {"C", "D", "E", "Z"}
        )
        self.assertSetEqual(
            self.example.get_items(Access.INTERFACE),
            set()
        )

    def test_remove_items(self):
        self.example.remove_items(set(["A", "B"]), Access.PUBLIC)
        self.example.remove_items(set(), Access.PRIVATE)
        self.example.remove_items(set(["Z", "Y"]), Access.INTERFACE)

        self.assertSetEqual(
            self.example.get_items(Access.PUBLIC),
            {"Z"}
        )
        self.assertSetEqual(
            self.example.get_items(Access.PRIVATE),
            {"C", "D", "E", "Z"}
        )
        self.assertSetEqual(
            self.example.get_items(Access.INTERFACE),
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
            union.get_items(Access.PUBLIC),
            {"A", "B", "C", "D"}
        )
        self.assertSetEqual(
            union.get_items(Access.PRIVATE),
            {"PA", "PB", "PC"}
        )
        self.assertSetEqual(
            union.get_items(Access.INTERFACE),
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
            intersection.get_items(Access.PUBLIC),
            set()
        )
        self.assertSetEqual(
            intersection.get_items(Access.PRIVATE),
            {"PA"}
        )
        self.assertSetEqual(
            intersection.get_items(Access.INTERFACE),
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
            self.example.get_items(Access.PUBLIC),
            {"A", "B", "Z", "C"}
        )
        self.assertSetEqual(
            self.example.get_items(Access.PRIVATE),
            {"E", "Z", "C", "D", "B"}
        )
        self.assertSetEqual(
            self.example.get_items(Access.INTERFACE),
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
            self.example.get_items(Access.PUBLIC),
            set()
        )
        self.assertSetEqual(
            self.example.get_items(Access.PRIVATE),
            {"C", "D"}
        )
        self.assertSetEqual(
            self.example.get_items(Access.INTERFACE),
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
            self.example.get_items(Access.PUBLIC),
            {"A", "B", "Z"}
        )
        self.assertSetEqual(
            self.example.get_items(Access.PRIVATE),
            {"E", "Z"}
        )
        self.assertSetEqual(
            self.example.get_items(Access.INTERFACE),
            set()
        )
