#!/usr/bin/env python3

from example_structure import example_create, example_convert_from_json, example_convert_to_json, example_validate

import json
import copy

def examples_load_from_file(filepath):
    """Load examples for a file

    Arguments:
        filepath {Filepath} -- Path to JSON file including examples list.

    Returns:
        Modules -- List of examples loaded from file.
    """
    with open(filepath, 'r') as file:
        examples = json.load(file)
        for example in examples:
            example_validate(example)
            example_convert_from_json(example)
        return examples
    return {}

def examples_save_to_file(filepath, examples):
    """Converts and saves examples into a file in JSON format

    Arguments:
        filepath {Filepath} -- Filepath to a location where examples are saved
        examples {Examples} -- List of examples to save
    """
    with open(filepath, 'w+') as file:
        for example in examples:
            example_convert_to_json(example)
        examples.sort(key=lambda e: e["path"], reverse=True)
        json.dump(examples, file)

def example_intersection_from_examples(examples, filter_function=None):
    """Creates a new example from intersections of sources, includes,
       flags etc. of passed list of examples. Filter function, if present, can
       be used to filter out selected examples.

    Arguments:
        examples {List of examples} -- List of examples from which intersection
        is created.

    Keyword Arguments:
        filter_function {function(Example)} -- Function filtering out selected
        examples from the operation.

    Returns:
        Example -- Example with intersected sets of sources, includes etc.
    """
    common_example = example_create()
    first_example = True
    for example in examples:
        # Filter example if needed
        if filter_function != None and filter_function(example):
            continue

        # First example populates array
        if first_example == True:
            common_example = copy.deepcopy(example)
            first_example = False
            continue

        # Make sure to keep elements which appear in every example.
        for key in common_example:
            if key in ["sources", "includes", "cflags", "asmflags", "ldflags"]:
                common_example[key].intersection_update(example[key])

    return common_example


def example_union_from_examples(examples, filter_function=None):
    """Creates a new example from unions of sources, includes,
       flags etc. of passed list of examples. Filter function, if present, can
       be used to filter out selected examples.

    Arguments:
        examples {List of examples} -- List of examples from which union
        is created.

    Keyword Arguments:
        filter_function {function(Example)} -- Function filtering out selected
        examples from the operation.

    Returns:
        Example -- Example with union sets of sources, includes etc.
    """
    sum_example = example_create()
    for example in examples:
        # Filter example if needed
        if filter_function != None and filter_function(example):
            continue

        # Sum all sources
        for key in sum_example:
            if key in ["sources", "includes", "cflags", "asmflags", "ldflags"]:
                sum_example[key].update(example[key])

    return sum_example
