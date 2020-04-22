#!/usr/bin/env python3

from jsonschema import validate as validate_json


def example_create():
    """Creates new example structure

    Returns:
        Example -- New, empty example
    """
    return {
        "path": '',
        "local_path": '',
        "sdk_version": '',
        "sources": set(),
        "includes": set(),
        "cflags": set(),
        "asmflags": set(),
        "ldflags": set(),
    }


def example_validate(json_example):
    """Validate JSON example structure

    Arguments:
        json_example {JSON} -- Example's JSON representation
    """
    validate_json(instance=json_example, schema={
        "type": "object",
        "required": [
            "path",
            "local_path",
            "sdk_version",
            "sources",
            "includes",
            "cflags",
            "asmflags",
            "ldflags",
        ],
        "properties": {
            "path": {
                "type": "string"
            },
            "local_path": {
                "type": "string"
            },
            "sdk_version": {
                "type": "string"
            },
            "sources": {
                "$ref": "#/definitions/string_array"
            },
            "includes": {
                "$ref": "#/definitions/string_array"
            },
            "cflags": {
                "$ref": "#/definitions/string_array"
            },
            "asmflags": {
                "$ref": "#/definitions/string_array"
            },
            "ldflags": {
                "$ref": "#/definitions/string_array"
            },
        },
        "definitions": {
            "string_array": {
                "type": "array",
                "items": {
                    "type": "string"
                }
            },
        }
    })


def example_convert_to_json(example):
    """Converts example to JSON format

    Arguments:
        example {Example} -- Example to convert to JSON format.

    Returns:
        JSON example -- Example in JSON format (modified in place)
    """
    example["sources"] = list(example["sources"])
    example["sources"].sort()
    example["includes"] = list(example["includes"])
    example["includes"].sort()
    example["cflags"] = list(example["cflags"])
    example["cflags"].sort()
    example["asmflags"] = list(example["asmflags"])
    example["asmflags"].sort()
    example["ldflags"] = list(example["ldflags"])
    example["ldflags"].sort()
    return example


def example_convert_from_json(example):
    """Convert example from json

    Arguments:
        example {Example's JSON} -- JSON format of an example

    Returns:
        Example -- Example instance (modified in place)
    """
    example["sources"] = set(example["sources"])
    example["includes"] = set(example["includes"])
    example["cflags"] = set(example["cflags"])
    example["asmflags"] = set(example["asmflags"])
    example["ldflags"] = set(example["ldflags"])
    return example
