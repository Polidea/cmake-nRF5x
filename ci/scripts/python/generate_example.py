#!/usr/bin/env python3

import os
import argparse
from pathlib import Path

from nrf5_cmake.library_operations import libraries_load_from_file, libraries_dependencies_per_sdk
from nrf5_cmake.library_description import LibraryDescription
from nrf5_cmake.library import Library
from nrf5_cmake.version import Version

from nrf5_cmake.example_operations import examples_load_from_file, library_from_example
from nrf5_cmake.example import Example

from jinja2 import FileSystemLoader, Environment
from typing import Dict, List, Optional, Set, Tuple

# Parse arguments
parser = argparse.ArgumentParser()
parser.add_argument("--examples", required=True)
parser.add_argument("--libraries", required=True)
parser.add_argument("--examples_dir", required=True)
parser.add_argument("--example_template", required=True)
parser.add_argument("--example_name", required=True)
args = parser.parse_args()

examples: str = args.examples
libraries: str = args.libraries
examples_dir: str = args.examples_dir
example_template: str = args.example_template
example_name: str = args.example_name

# Load necessary files
all_examples: List[Example] = examples_load_from_file(examples)
all_libraries: Dict[str,
                    LibraryDescription] = libraries_load_from_file(libraries)

# Find all examples for supported SDKs and create an union from them.
union_example: Optional[Library] = None
supported_sdks: Set[Version] = set()

for example in all_examples:
    if example.local_path != "examples/" + example_name:
        continue

    supported_sdks.add(example.sdk_version)

    if union_example:
        union_example.union_update(library_from_example(example))
    else:
        union_example = library_from_example(example)

# For each source file, find a library.
found_libraries: Dict[str, LibraryDescription] = {}


def library_for_source(source_file: str) -> Optional[Tuple[str, Set[str]]]:
    for (library_name, library) in all_libraries.items():
        all_sources = library.library.sources.copy()
        for patch in library.patches:
            all_sources.update(patch.library.sources)
        if source_file in all_sources:
            return (library_name, all_sources)

    return None


while len(union_example.sources) > 0:
    source = union_example.sources.pop()
    library = library_for_source(source)
    if library == None:
        continue

    union_example.sources.difference_update(library[1])
    found_libraries[library[0]] = all_libraries[library[0]]

output_file = Path(examples_dir).joinpath(
    example_name).joinpath("CMakeLists.txt")

os.makedirs(output_file.parent)

with open(example_template, 'r') as template_file, open(output_file, 'w') as output_file:
    template = Environment(
        loader=FileSystemLoader(Path(example_template).resolve().parent)
    ).from_string(template_file.read())
    output_file.write(template.render(
        name=Path(example_name).parts[-1],
        path=example_name,
        libraries=sorted([x for x in found_libraries])
    ))
