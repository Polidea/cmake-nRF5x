#!/usr/bin/env python3

from module_structure import module_create
from example_structure import example_create
from module_structure import items_with_access_union


def example_filter_items_present_in_modules(example, modules):
    """Removes all items (sources, includes, etc.) which are present in
       passed modules.

    Arguments:
        example {Example} -- Example which is modified
        modules {Modules} -- List (Module name, Module) tuple.
    """
    filtered_sets = ["sources"]
    filtered_items = ["includes", "cflags", "asmflags", "ldflags"]
    for (_, module) in modules:
        for item in filtered_items:
            example[item].difference_update(
                items_with_access_union(module[item]))
        for filtered_set in filtered_sets:
            example[filtered_set].difference_update(module[filtered_set])


def module_convert_from_example(example):
    """Converts example into a module.

    Arguments:
        example {Example} -- Example to be converted into module

    Returns:
        Module -- Module converted from example
    """
    module = module_create()
    converted_sets = ["sources"]
    converted_items = ["includes", "cflags", "asmflags", "ldflags"]
    for item in converted_items:
        module[item]["public"] = example[item]
    for converted_set in converted_sets:
        module[converted_set] = example[converted_set]
    return module


def example_convert_from_module(module):
    """Coverts module into example

    Arguments:
        module {Module} -- Module to convert

    Returns:
        Example -- Example converted from module
    """
    example = example_create()
    converted_sets = ["sources"]
    converted_items = ["includes", "cflags", "asmflags", "ldflags"]
    for item in converted_items:
        example[item] = items_with_access_union(module[item])
    for converted_set in converted_sets:
        example[converted_set] = module[converted_set]
    return example
