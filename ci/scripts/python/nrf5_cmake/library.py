from __future__ import annotations

from unittest import TestCase
from enum import Enum
from typing import Dict, Iterable, Optional, Set, List
from jsonschema import validate as validate_json

from nrf5_cmake.property import Access, Property
from nrf5_cmake.version import Version


class LibraryProperty(Enum):
    DEPENDENCIES = "dependencies"
    INCLUDES = "includes"
    CFLAGS = "cflags"
    ASMFLAGS = "asmflags"
    LDFLAGS = "ldflags"


class Library:

    props_json_schema = {
        "sources": {
            "type": "array",
            "items": {
                "type": "string"
            }
        },
        ** {x.value: Property.json_schema for x in LibraryProperty}
    }

    json_schema = {
        "type": "object",
        "properties": props_json_schema
    }

    def __init__(self,
                 sources: Optional[Set[str]] = None,
                 dependencies: Optional[Property] = None,
                 includes: Optional[Property] = None,
                 cflags: Optional[Property] = None,
                 asmflags: Optional[Property] = None,
                 ldflags: Optional[Property] = None
                 ):
        self._sources: Set[str] = sources or set()
        self._props: Dict[LibraryProperty, Property] = {}
        self._props[LibraryProperty.DEPENDENCIES] = dependencies or Property()
        self._props[LibraryProperty.INCLUDES] = includes or Property()
        self._props[LibraryProperty.CFLAGS] = cflags or Property()
        self._props[LibraryProperty.ASMFLAGS] = asmflags or Property()
        self._props[LibraryProperty.LDFLAGS] = ldflags or Property()

    def __str__(self):
        return str(self.to_json())

    def __eq__(self, other: object) -> bool:
        if not isinstance(other, Library):
            return False
        if self._sources != other._sources:
            return False
        for prop in LibraryProperty:
            if self._props[prop] != other._props[prop]:
                return False
        return True

    @staticmethod
    def from_json(json_value: dict) -> Library:
        validate_json(instance=json_value,
                      schema=Library.json_schema)

        library_props = Library()
        if "sources" in json_value:
            library_props._sources = set(json_value["sources"])

        for property_name in LibraryProperty:
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

        for property_name in LibraryProperty:
            if len(self._props[property_name].get_all_items()) == 0:
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

    def get_prop(self, property_name: LibraryProperty) -> Property:
        return self._props[property_name]

    def set_prop(self, property_name: LibraryProperty, prop: Property):
        self._props[property_name] = prop

    @staticmethod
    def _prop_action(libraries: Iterable[Library], set_action, prop_action):
        library = Library()
        sources: List[Set[str]] = []
        properties: Dict[LibraryProperty, List[Property]] = {
            prop: [] for prop in LibraryProperty
        }

        for lib in libraries:
            sources.append(lib._sources)
            for prop in LibraryProperty:
                properties[prop].append(lib._props[prop])

        if sources:
            library._sources = set_action(*sources)

        for prop in LibraryProperty:
            if properties[prop]:
                library._props[prop] = prop_action(
                    properties[prop],
                    Access.PUBLIC
                )

        return library

    @staticmethod
    def union(libraries: Iterable[Library]) -> Library:
        return Library._prop_action(libraries, set.union, Property.union)

    def union_update(self, library: Library):
        self._sources.update(library._sources)
        for prop in LibraryProperty:
            self._props[prop].union_update(
                library._props[prop],
                Access.PUBLIC
            )

    @staticmethod
    def intersection(libraries: Iterable[Library]) -> Library:
        return Library._prop_action(libraries, set.intersection, Property.intersection)

    def intersection_update(self, library: Library):
        self._sources.intersection_update(library._sources)
        for prop in LibraryProperty:
            self._props[prop].intersection_update(
                library._props[prop],
                Access.PUBLIC
            )

    @staticmethod
    def difference(libraries: Iterable[Library]) -> Library:
        return Library._prop_action(libraries, set.difference, Property.difference)

    def difference_update(self, library: Library):
        self._sources.difference_update(library._sources)
        for prop in LibraryProperty:
            self._props[prop].difference_update(
                library._props[prop],
                Access.PUBLIC
            )


class LibraryTestCase(TestCase):
    def setUp(self):
        self.lib1 = Library(
            sources={'s1', 's2'},
            includes=Property(
                public={"pub_inc1", "pub_inc2"},
                private={'prv_inc1', "prv_inc2"}
            )
        )
        self.lib2 = Library(
            sources={'s1', 's2', 's3'},
            includes=Property(
                public={"pub_inc1", "pub_inc2", "pub_inc3"},
                private={'prv_inc1', "prv_inc2", "prv_inc3"}
            ),
            dependencies=Property(
                public={"dep1", "dep2"}
            )
        )
        self.lib3 = Library(
            sources={'s2', 's3'},
            includes=Property(
                public={"pub_inc2", "pub_inc3"},
                private={'prv_inc2', "prv_inc3"}
            )
        )

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

        value = Library.from_json(json_value)
        self.assertSetEqual(value.sources, {"s1", "s2"})

        LP = LibraryProperty
        self.assertEqual(
            value.get_prop(LP.DEPENDENCIES),
            Property(private={"dep1", "dep2"})
        )
        self.assertEqual(
            value.get_prop(LP.INCLUDES),
            Property(public={"inc1"})
        )
        self.assertEqual(
            value.get_prop(LP.CFLAGS),
            Property(interface={"int1"})
        )
        self.assertEqual(
            value.get_prop(LP.ASMFLAGS),
            Property(public={"asm1"})
        )
        self.assertEqual(
            value.get_prop(LP.LDFLAGS),
            Property(public={"ld1"})
        )

        self.assertEqual(json_value, value.to_json())

    def test_union(self):
        self.assertEqual(
            Library.union([]),
            Library()
        )

        union_lib = Library.union([self.lib1, self.lib2, self.lib3])
        self.assertEqual(
            union_lib,
            Library(
                sources={'s1', 's2', 's3'},
                includes=Property(
                    public={"pub_inc1", "pub_inc2", "pub_inc3"},
                    private={'prv_inc1', "prv_inc2", "prv_inc3"}
                ),
                dependencies=Property(
                    public={"dep1", "dep2"}
                )
            )
        )

    def test_union_update(self):
        self.lib1.union_update(self.lib2)
        self.assertEqual(
            self.lib1,
            Library(
                sources={'s1', 's2', 's3'},
                includes=Property(
                    public={"pub_inc1", "pub_inc2", "pub_inc3"},
                    private={'prv_inc1', "prv_inc2", "prv_inc3"}
                ),
                dependencies=Property(
                    public={"dep1", "dep2"}
                )
            )
        )

    def test_intersection(self):
        self.assertEqual(
            Library.intersection([]),
            Library()
        )

        intersection = Library.intersection([self.lib1, self.lib2, self.lib3])
        self.assertEqual(
            intersection,
            Library(
                sources={'s2'},
                includes=Property(
                    public={"pub_inc2"},
                    private={"prv_inc2"}
                )
            )
        )

    def test_intersection_update(self):
        self.lib1.intersection_update(self.lib2)
        self.assertEqual(
            self.lib1,
            Library(
                sources={'s1', 's2'},
                includes=Property(
                    public={"pub_inc1", "pub_inc2"},
                    private={"prv_inc1", "prv_inc2"}
                )
            )
        )

    def test_difference_update(self):
        self.lib2.difference_update(self.lib1)
        self.assertEqual(
            self.lib2,
            Library(
                sources={'s3'},
                includes=Property(
                    public={"pub_inc3"},
                    private={"prv_inc3"}
                ),
                dependencies=Property(
                    public={"dep1", "dep2"}
                )
            )
        )
