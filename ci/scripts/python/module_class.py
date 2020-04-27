#!/usr/bin/env python3

import pprint
from jsonschema import validate as validate_json

string_array_json_schema = {
    "type": "array",
    "items": {
        "type": "string"
    }
}


class Module:
    types = ["builtin", "object", "interface"]

    json_schema = {
        "type": "object",
        "additionalProperties": False,
        "required": ["type"],
        "properties": {
            **ModuleProps.props_json_schema,
            **{
                "documentation": {
                    "type": "string"
                },
                "type": {
                    "type": "string",
                    "enum": types
                },
                "patches": {
                    "type": "array",
                    "items": {
                        "type": "object",
                        "additionalProperties": False,
                        "properties": ModuleProps.props_json_schema
                    }
                }
            }
        }
    }

    def __init__(self):
        self._props = ModuleProps()
        self._documentation = ""
        self._type = ""
        self._patches = []

    def __str__(self):
        return str(self.to_json())

    def from_json(self, json_module):
        validate_json(instance=json_module,
                      schema=Module.json_schema)

        if "documentation" in json_module:
            self._documentation = json_module["documentation"]
        else:
            self._documentation = ""

        if "type" in json_module:
            self._type = json_module["type"]
        else:
            self._type = "object"

        props = ModuleProps()
        props.from_json(json_module)
        self._props = props

        patches = []
        if "patches" in json_module:
            for patch in json_module["patches"]:
                patch_props = ModuleProps()
                patch_props.from_json(patch)
                patches.append(patch_props)
        self._patches = patches

    def to_json(self):
        json_value = {}
        if self._documentation:
            json_value["documentation"] = self._documentation
        if self._type:
            json_value["type"] = self._type
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


module = Module()
module.from_json({"type": "object", "sources": [],
                  "patches": [{"sources": ["ok"]}]})
print(module)


def module_create():
    """Creates new empty module

    Returns:
        Module -- New module
    """
    return {
        "documentation": "",
        "category": "",
        "type": "object",
        "sources": set(),
        "dependencies": items_with_access_modifiers_create(),
        "includes": items_with_access_modifiers_create(),
        "cflags": items_with_access_modifiers_create(),
        "asmflags": items_with_access_modifiers_create(),
        "ldflags": items_with_access_modifiers_create(),
    }


def module_convert_from_json(module):
    """Convert Module's JSON to module

    Arguments:
        module {Module's JSON} -- JSON representation of a module

    Returns:
        Module -- Module instance
    """
    module["sources"] = set(module["sources"])
    items_with_access_convert_from_json(module["dependencies"])
    items_with_access_convert_from_json(module["includes"])
    items_with_access_convert_from_json(module["cflags"])
    items_with_access_convert_from_json(module["asmflags"])
    items_with_access_convert_from_json(module["ldflags"])
    return module


def module_get_all_dependencies(module):
    """Returns all dependencies regardless of access pattern

    Arguments:
        module {Example} -- Example from which we get dependencies flags.

    Returns:
        Items -- Merged items from dependencies field.
    """
    return items_with_access_union(module["dependencies"])


def module_get_all_includes(module):
    """Returns all includes regardless of access pattern

    Arguments:
        module {Example} -- Example from which we get includes flags.

    Returns:
        Items -- Merged items from includes field.
    """
    return items_with_access_union(module["includes"])


def module_get_all_cflags(module):
    """Returns all cflags regardless of access pattern

    Arguments:
        module {Example} -- Example from which we get cflags flags.

    Returns:
        Items -- Merged items from cflags field.
    """
    return items_with_access_union(module["cflags"])


def module_get_all_asmflags(module):
    """Returns all asmflags regardless of access pattern

    Arguments:
        module {Example} -- Example from which we get asmflags flags.

    Returns:
        Items -- Merged items from asmflags field.
    """
    return items_with_access_union(module["asmflags"])


def module_get_all_ldflags(module):
    """Returns all ldflags regardless of access pattern

    Arguments:
        module {Example} -- Example from which we get ldflags flags.

    Returns:
        Items -- Merged items from ldflags field.
    """
    return items_with_access_union(module["ldflags"])


def module_including_source(source, modules):
    """This function returns pair (module_name, module), which includes source
       file or None value otherwise.

    Arguments:
        source {Source file} -- Source which should be included in the module
        modules {Modules} -- List of modules to choose from

    Returns:
        (Module name, Module) -- First module which includes source file.
    """
    for module_name in modules:
        module = modules[module_name]
        if source in module["sources"]:
            return (module_name, module)
    return None
