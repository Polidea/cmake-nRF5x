#!/usr/bin/env python3

from module_structure import module_convert_from_json, module_convert_to_json, module_validate

import json


def modules_load_from_file(filepath):
    """Load modules for a file

    Arguments:
        filepath {Filepath} -- Path to JSON file including modules dict.

    Returns:
        Modules -- Dictionary of modules loaded from file.
    """
    with open(filepath, 'r') as file:
        modules = json.load(file)
        for module_name in modules:
            module = modules[module_name]
            module_validate(module)
            module_convert_from_json(module)
        return modules
    return {}


def modules_save_to_file(filepath, modules):
    """Converts and saves modules into a file in JSON format

    Arguments:
        filepath {Filepath} -- Filepath to a location where modules are saved
        modules {Modules} -- List of modules to save
    """
    with open(filepath, 'w+') as file:
        for module_key in modules:
            module = modules[module_key]
            module_convert_to_json(module)
        json.dump(modules, file)
