#!/usr/bin/env python3

from jsonschema import validate as validate_json

# Items with access modifiers  -------------------------------------------------

items_with_access_modifier_schema = {
    "type": "object",
    "required": ["public", "interface", "private"],
    "properties": {
        "public": {
            "$ref": "#/definitions/string_array"
        },
        "interface": {
            "$ref": "#/definitions/string_array"
        },
        "private": {
            "$ref": "#/definitions/string_array"
        }
    }
}


def items_with_access_modifiers_create():
    """Creates a generic structure for items with structure

    Returns:
        Items -- Items with access modifiers.
    """
    return {
        "public": set(),
        "private": set(),
        "interface": set(),
    }


def items_with_access_convert_to_json(items):
    """Converts items with access modifiers to JSON

    Arguments:
        items {Items} -- Items to convert to JSON format
    """
    items["public"] = list(items["public"])
    items["public"].sort()
    items["private"] = list(items["private"])
    items["private"].sort()
    items["interface"] = list(items["interface"])
    items["interface"].sort()


def items_with_access_convert_from_json(items):
    """Converts items with access modifiers from JSON

    Arguments:
        items {Items} -- Items to convert from JSON format
    """
    items["public"] = set(items["public"])
    items["private"] = set(items["private"])
    items["interface"] = set(items["interface"])


def items_with_access_union(items):
    """Merges all items regarldess of access value

    Arguments:
        items {Item} -- Items to merge

    Returns:
        Set -- Merged items
    """
    return set.union(items["public"], items["private"], items["interface"])

# Modules ----------------------------------------------------------------------


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


def module_validate(json_module):
    """Validate JSON module structure

    Arguments:
        json_module {JSON} -- Example's JSON representation
    """
    validate_json(instance=json_module, schema={
        "type": "object",
        "required": [
            "documentation",
            "category",
            "type",
            "dependencies",
            "sources",
            "includes",
            "cflags",
            "asmflags",
            "ldflags",
        ],
        "properties": {
            "documentation": {
                "type": "string"
            },
            "category": {
                "type": "string"
            },
            "type": {
                "type": "string",
                "enum": ["object", "interface"]
            },
            "sources": {
                "$ref": "#/definitions/string_array"
            },
            "dependencies": {
                "$ref": "#/definitions/items_with_access_modifier"
            },
            "includes": {
                "$ref": "#/definitions/items_with_access_modifier"
            },
            "cflags": {
                "$ref": "#/definitions/items_with_access_modifier"
            },
            "asmflags": {
                "$ref": "#/definitions/items_with_access_modifier"
            },
            "ldflags": {
                "$ref": "#/definitions/items_with_access_modifier"
            },
        },
        "definitions": {
            "string_array": {
                "type": "array",
                "items": {
                    "type": "string"
                }
            },
            "items_with_access_modifier": items_with_access_modifier_schema
        }
    })


def module_convert_to_json(module):
    """Convert module to JSON representation

    Arguments:
        module {Module} -- Module object

    Returns:
        Module's JSON -- JSON representation of a module
    """
    module["sources"] = list(module["sources"])
    module["sources"].sort()
    items_with_access_convert_to_json(module["dependencies"])
    items_with_access_convert_to_json(module["includes"])
    items_with_access_convert_to_json(module["cflags"])
    items_with_access_convert_to_json(module["asmflags"])
    items_with_access_convert_to_json(module["ldflags"])
    return module


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
