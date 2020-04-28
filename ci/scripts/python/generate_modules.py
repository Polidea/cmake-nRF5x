#!/usr/bin/env python3

import argparse
from nrf5_cmake.library_description import LibraryDescription
import pprint

from nrf5_cmake.library_operations import libraries_load_from_file, libraries_save_to_file
from nrf5_cmake.example_operations import library_from_example, examples_load_from_file
from nrf5_cmake.example import Example, ExampleProperty
from nrf5_cmake.library import Library, LibraryProperty
from nrf5_cmake.property import Access
from typing import Dict, Iterable

pp = pprint.PrettyPrinter()


def generate_libraries(examples: Iterable[Example],
                       known_libraries: Dict[str, LibraryDescription]) -> Dict[str, LibraryDescription]:
    # This dict contains new, generated libraries
    gen_libraries: Dict[str, LibraryDescription] = {}
    gen_library_count: int = 0

    # All defined libraries iterator
    def libraries_iter():
        for known_lib in known_libraries.items():
            yield (known_lib[0], known_lib[1].library)
        for gen_lib in gen_libraries.items():
            yield (gen_lib[0], gen_lib[1].library)

    # Remove duplicates from a library which exists in already known and
    # generated libraries.
    def remove_duplicates(library: Library):
        for lib in libraries_iter():
            library.difference_update(lib[1])

    # This function finds intersection library from all examples which include
    # source file.
    def intersection_library_including_src(source: str) -> Library:
        return Library.intersection(
            library_from_example(e) for e in examples
            if source in e.get_prop(ExampleProperty.SOURCES)
        )

    # This function creates union library from all examples

    def union_library() -> Library:
        return Library.union((library_from_example(x) for x in examples))

    # Collect union library from all examples and remove entires already present
    # in other libraries.
    union_lib = union_library()
    remove_duplicates(union_lib)

    # Iterate until all sources are processed from the union library
    while len(union_lib.sources) > 0:
        # Pick first source at random
        union_lib_src = next(iter(union_lib.sources))

        #  Get intersection library from all libraries which include union_lib_src
        library = intersection_library_including_src(union_lib_src)
        remove_duplicates(library)

        # Check if every source in the above library always appears in every
        # known example. That would suggest sources are part of the same lib.
        smaller_lib_found = True
        while smaller_lib_found:
            # Let's assume we didn't find smaller library...
            smaller_lib_found = False

            # Iterate all library's sources.
            for lib_src in library.sources:

                # Find intersection library from all examples which includes lib_src
                other_library = intersection_library_including_src(lib_src)
                remove_duplicates(other_library)

                # Intersect two libraries and check if sources remain the same.
                merged_library = Library.intersection([library, other_library])
                if len(merged_library.sources) != len(library.sources):
                    smaller_lib_found = True
                    library = merged_library
                    break

        # Name library and add it to generated libraries
        gen_libraries["lib" + str(gen_library_count)] = \
            LibraryDescription(library=library)
        gen_library_count += 1

        # Removed used sources and other props from union_lib
        union_lib.difference_update(library)

    # Validate all libraries by checking that all sources, includes etc. are
    # covered by gathered libs. These are only warnings.
    union_lib_from_examples = union_library()
    union_lib_from_libs = Library.union(
        x[1] for x in libraries_iter()
    )

    # Check differences
    union_lib_from_examples.difference_update(union_lib_from_libs)
    if len(union_lib_from_examples.sources) > 0:
        print("WARNING: sources not handled:")
        pp.pprint(union_lib_from_examples.sources)

    for prop in LibraryProperty:
        if len(union_lib_from_examples.get_prop(prop).get_items(Access.ALL)) > 0:
            print("WARNING: " + prop.value + " not handled:")
            for access in Access.ALL.matches:
                print("Access: " + access.value)
                pp.pprint(
                    union_lib_from_examples.get_prop(prop).get_items(access)
                )

    # Return all libraries
    return {
        **{name: lib for name, lib in known_libraries.items()},
        **{name: lib for name, lib in gen_libraries.items()}
    }


# def generate_module_dependencies(examples, modules):
#     for module_name in modules:
#         module = modules[module_name]

#         # Get common example which includes all files from the modules
#         def includes_all_sources_from_module(example):
#             intersection = example["sources"].intersection(module["sources"])
#             return len(intersection) != len(module["sources"])

#         common_example = example_intersection_from_examples(
#             examples, includes_all_sources_from_module)

#         # Remove sources from common example
#         common_example["sources"].difference_update(module["sources"])

#         # While there are any sources left we try to find module for them.
#         dependencies = items_with_access_modifiers_create()
#         while len(common_example["sources"]) > 0:

#             # Take one random source and find module for it.
#             source = common_example["sources"].pop()
#             found_module = module_including_source(source, modules)

#             if found_module == None:
#                 print("WARNING: module not found for: " + source)
#             else:
#                 dependencies["public"].add(found_module[0])
#                 common_example["sources"].difference_update(
#                     found_module[1]["sources"])

#         # Update module's dependencies:
#         module["dependencies"] = dependencies


# Parse arguments
parser = argparse.ArgumentParser()
parser.add_argument("--all_examples")
parser.add_argument("--builtin_modules")
parser.add_argument("--cmake_modules")
parser.add_argument("--output")
args = parser.parse_args()

# List of all examples with sources, includes etc.
all_examples = examples_load_from_file(args.all_examples)

# Load builtin and cmake modules
builtin_modules = libraries_load_from_file(args.builtin_modules)
cmake_modules = libraries_load_from_file(args.cmake_modules)

# Generates modules
modules = generate_libraries(all_examples, {
    **{name: value for name, value in builtin_modules.items()},
    **{name: value for name, value in cmake_modules.items()},
})

# Generate dependencies
# generate_module_dependencies(all_examples, modules)

# Convert modules to JSON and save to ouptut file
libraries_save_to_file(args.output, modules)
