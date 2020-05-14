from __future__ import annotations

import json

from nrf5_cmake.library_description import LibraryDescription
from typing import Any, Dict


def libraries_load_from_file(filepath: str) -> Dict[str, LibraryDescription]:
    libs: Dict[str, LibraryDescription] = {}
    with open(filepath, 'r') as file:
        json_libs: Dict[str, Any] = json.load(file)

        if not isinstance(json_libs, dict):
            raise Exception("Exampected a dictionary of libraries")

        for json_lib_name in json_libs:
            json_lib = json_libs[json_lib_name]
            libs[json_lib_name] = LibraryDescription.from_json(json_lib)

    return libs


def libraries_save_to_file(filepath: str, libraries: Dict[str, LibraryDescription]):
    json_libs: Dict[str, Any] = {}

    with open(filepath, 'w') as file:
        for lib_name, lib in libraries.items():
            json_libs[lib_name] = lib.to_json()

        json.dump(json_libs, file, indent=2)
