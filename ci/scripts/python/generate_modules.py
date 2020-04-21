#!/usr/bin/env python3

import re
import argparse
import json
import copy
import sys

import pprint
pp = pprint.PrettyPrinter()

# Creates empty module
def empty_module():
    return {
        "sources": set(),
        "includes": set(),
        "cflags": set(),
        "asmflags": set(),
        "ldflags": set(),
        "dependencies": set()
    }

# Creates empty example with proper structure
def empty_example():
    return {
        "path": '',
        "local_path": '',
        "sdk_version": '',
        "sources": set(),
        "includes": set(),
        "cflags": set(),
        "asmflags": set(),
        "ldflags": set()
    }

def example_to_module(example):
    return {
        "sources": example["sources"],
        "includes": example["includes"],
        "cflags": example["cflags"],
        "asmflags": example["asmflags"],
        "ldflags": example["ldflags"],
        "dependencies": set()
    }

# Convert module to example
def module_to_example(module):
    return {
        "path": '',
        "local_path": '',
        "sdk_version": '',
        "sources": module["sources"],
        "includes": module["includes"],
        "cflags": module["cflags"],
        "asmflags": module["asmflags"],
        "ldflags": module["ldflags"],
    }

# Convert JSON example which includes list into set example format.
def convert_example_from_json(example):
    example["sources"] = set(example["sources"])
    example["includes"] = set(example["includes"])
    example["cflags"] = set(example["cflags"])
    example["asmflags"] = set(example["asmflags"])
    example["ldflags"] = set(example["ldflags"])

# Convert module to JSON representation
def convert_module_to_json(module):
    module["sources"] = list(module["sources"])
    module["sources"].sort()
    module["includes"] = list(module["includes"])
    module["includes"].sort()
    module["cflags"] = list(module["cflags"])
    module["cflags"].sort()
    module["asmflags"] = list(module["asmflags"])
    module["asmflags"].sort()
    module["ldflags"] = list(module["ldflags"])
    module["ldflags"].sort()
    module["dependencies"] = list(module["dependencies"])
    module["dependencies"].sort()

# Get a common definition of an example with sources, includes, flags which
# are included by every example.
def get_common_example(examples, filter_function=None):
    common_example = empty_example()
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
            if key == "path" or key == "local_path" or key == "sdk_version":
                continue
            common_example[key].intersection_update(example[key])

    return common_example

# Get an union definition of all examples' sources, includes etc.
def get_union_example(examples, filter_function=None):
    sum_example = empty_example()
    for example in examples:
        # Filter example if needed
        if filter_function != None and filter_function(example):
            continue
        
        # Sum all sources
        for key in sum_example:
            if key == "path" or key == "local_path" or key == "sdk_version":
                continue
            sum_example[key].update(example[key])

    return sum_example

# Generate modules based on the knowledge from the examples, our assumptions
# and work done as a part of CMake definitions.
def generate_modules(examples, modules_builtin, modules_cmake):
    # This dict contains new modules
    modules = {}
    module_count = 0

    # All defined modules iterator
    def modules_iterator():
        for modules_dict in [modules_builtin, modules_cmake, modules]:
            for module in modules_dict.items():
                yield module

    # Remove duplicates from module's sources, includes etc.
    def remove_duplicates_from_modules(example):
        for module in modules_iterator():
            example["sources"].difference_update(module[1]["sources"])
            example["includes"].difference_update(module[1]["includes"])
            example["cflags"].difference_update(module[1]["cflags"])
            example["asmflags"].difference_update(module[1]["asmflags"])
            example["ldflags"].difference_update(module[1]["ldflags"])

    # Collect sum example
    union_example = get_union_example(examples)

    # Iterate until all sources are processed
    while len(union_example["sources"]) > 0:
        # Pick first source at random
        union_source = next(iter(union_example["sources"]))

        #  Get common example for all examples which include union_source
        example = get_common_example(examples, lambda e: not union_source in e["sources"])
        remove_duplicates_from_modules(example)

        # Check if every source in the above example is always paired together
        smaller_example_found = True
        while smaller_example_found:
            # Let's assume we didn't find smaller example...
            smaller_example_found = False

            # Iterate all example's sources.
            for example_source in example["sources"]:

                # Find other common example which always includes example_source
                other_example = get_common_example(examples, lambda e: not example_source in e["sources"])
                remove_duplicates_from_modules(other_example)

                # Check if examples are minimal
                merged_example = get_common_example([example, other_example])
                if len(merged_example["sources"]) != len(example["sources"]):
                    smaller_example_found = True                    
                    example = merged_example
                    break

        # Name module and add it to modules
        module = example_to_module(example)
        module_count += 1
        modules["module" + str(module_count)] = module

        # Removed used sources from union_example
        union_example["sources"].difference_update(module["sources"])
    
    # Validate all modules by checking that all sources, includes etc. are
    # covered by modules. These are only warning.
    union_example = get_union_example(examples)
    examples_from_module = []
    for module in modules_iterator():
        examples_from_module.append(module_to_example(module[1]))
    union_example_from_modules = get_union_example(examples_from_module)

    keys_to_validate = ["sources", "includes", "cflags", "asmflags", "ldflags"]
    for key in keys_to_validate:
        union_example[key].difference_update(union_example_from_modules[key])
        if len(union_example[key]) > 0:
            print("WARNING: " + key + " not handled:")
            pp.pprint(union_example[key])

    # Return all modules
    all_modules = {}
    for module in modules_iterator():
        all_modules[module[0]] = module[1]
    return all_modules

# This function returns pair (module_name, module), which includes source file
# or None value otherwise.
def module_including_source(source, modules):
    for module_name in modules:
        module = modules[module_name]
        if source in module["sources"]:
            return (module_name, module)
    return None

# Function generates module's dependencies by looking at examples and quessing
# them. If for all examples that use modules there are other files, we try to
# find dependecy for them.
def generate_module_dependencies(examples, modules):
    for module_name in modules:
        module = modules[module_name]

        # Get common example which includes all files from the modules
        def includes_all_sources_from_module(example):
            intersection = example["sources"].intersection(module["sources"])
            return len(intersection) != len(module["sources"])

        common_example = get_common_example(examples, includes_all_sources_from_module)

        # Remove sources from common example
        common_example["sources"].difference_update(module["sources"])

        # While there are any sources left we try to find module for them.
        dependencies = set()
        while len(common_example["sources"]) > 0:

            # Take one random source and find module for it.
            source = common_example["sources"].pop()
            found_module = module_including_source(source, modules)

            if found_module == None:
                print("WARNING: module not found for: " + source)
            else:
                dependencies.add(found_module[0])
                common_example["sources"].difference_update(found_module[1]["sources"])

        # Update module's dependencies:
        module["dependencies"] = dependencies

# Parse arguments
parser = argparse.ArgumentParser()
parser.add_argument("--all_examples")
parser.add_argument("--output")
args = parser.parse_args()

# List of all examples with sources, includes etc.
all_examples_file = open(args.all_examples, 'r')
all_examples = json.load(all_examples_file)
for example in all_examples:
    convert_example_from_json(example)

# Generates modules
modules = generate_modules(all_examples, {}, {})

# Generate dependencies
generate_module_dependencies(all_examples, modules)

# Convert modules to JSON and save to ouptut file
json_modules = {}
for module_key in modules:
    module = modules[module_key]
    convert_module_to_json(module)
    json_modules[module_key] = module

output_file = open(args.output, 'w+')
json.dump(json_modules, output_file)
