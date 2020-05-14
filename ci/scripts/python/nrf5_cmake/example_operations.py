from __future__ import annotations

import json
from nrf5_cmake.property import Property
from nrf5_cmake.library import Library
from nrf5_cmake.example import Example, ExampleProperty
from typing import Iterable, List


def examples_load_from_file(filepath: str) -> List[Example]:
    examples: List[Example] = []

    with open(filepath, 'r') as file:
        json_examples: List = json.load(file)
        if not isinstance(json_examples, list):
            raise Exception("Example file should be a JSON array!")

        for json_example in json_examples:
            example = Example.from_json(json_example)
            examples.append(example)

    return examples


def examples_save_to_file(filepath: str, examples: Iterable[Example]):
    with open(filepath, 'w') as file:

        json_examples = []
        for example in examples:
            json_examples.append(example.to_json())

        json_examples.sort(key=lambda e: e["path"], reverse=True)
        json.dump(json_examples, file, indent=2)


def library_from_example(example: Example) -> Library:
    return Library(sources=example.get_prop(ExampleProperty.SOURCES),
                   includes=Property(public=example.get_prop(
                       ExampleProperty.INCLUDES)),
                   cflags=Property(public=example.get_prop(
                       ExampleProperty.CFLAGS)),
                   asmflags=Property(public=example.get_prop(
                       ExampleProperty.ASMFLAGS)),
                   ldflags=Property(public=example.get_prop(
                       ExampleProperty.LDFLAGS))
                   )
