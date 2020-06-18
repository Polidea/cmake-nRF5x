#!/usr/bin/env python3

import re
import sys
import argparse
import pprint

from nrf5_cmake.library_description import LibraryDescription
from nrf5_cmake.library_operations import libraries_load_from_file, libraries_save_to_file
from nrf5_cmake.example_operations import library_from_example, examples_load_from_file
from nrf5_cmake.example import Example, ExampleProperty
from nrf5_cmake.library import Library, LibraryProperty
from nrf5_cmake.property import Access, Property
from typing import Dict, Iterable, List, Optional, Tuple

pp = pprint.PrettyPrinter()


def generate_libraries(examples: Iterable[Example],
                       known_libraries: Dict[str, LibraryDescription]) -> Dict[str, LibraryDescription]:
    # Print what we are doing...
    print("Generating modules...")

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

        # Show progress...
        sys.stdout.write("\rRemaining sources: " +
                         str(len(union_lib.sources)).ljust(4)
                         )

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
    print("\nFinished processing all sources!")

    union_lib_from_examples.difference_update(union_lib_from_libs)
    if len(union_lib_from_examples.sources) > 0:
        print("WARNING: sources not handled:")
        pp.pprint(union_lib_from_examples.sources)

    for prop in LibraryProperty:
        all_items = union_lib_from_examples.get_prop(prop).get_all_items()
        if len(all_items) > 0:
            print("WARNING: " + prop.value + " not handled:")
            pp.pprint(all_items)

    # Return generated libs
    return gen_libraries


def find_library_including_source(source: str, lib_descs: Dict[str, LibraryDescription]) -> Optional[Tuple[str, LibraryDescription]]:
    for lib_desc_tuple in lib_descs.items():
        if source in lib_desc_tuple[1].library.sources:
            return lib_desc_tuple
    return None


def generate_libraries_dependencies(
        examples: List[Example],
        lib_descs: Dict[str, LibraryDescription]):

    print("Generating dependencies...")
    remaining_deps = len(lib_descs)

    for lib_desc_name in lib_descs:
        lib_desc = lib_descs[lib_desc_name]

        # Get info about dependencies generation
        sys.stdout.write("\rRemaining dependencies: " +
                         str(remaining_deps).ljust(4)
                         )
        remaining_deps -= 1

        # Ignore user defined libraries.
        if not re.match(r"lib[0-9]+", lib_desc_name):
            continue

        # Function which checks if all sources from the library are included
        # in the example sources

        def includes_all_sources_from_library(example: Example):
            example_sources = example.get_prop(ExampleProperty.SOURCES)
            library_sources = lib_desc.library.sources
            sources_intersection = set.intersection(
                example_sources,
                library_sources
            )
            return len(sources_intersection) == len(library_sources)

        # Find library converted from all examples, which include all sources
        # from the library.
        intersection_lib = Library.intersection(
            library_from_example(example) for example in examples
            if includes_all_sources_from_library(example)
        )

        # Remove used resources from library
        intersection_lib.difference_update(lib_desc.library)

        # While there are any sources left we try to find library for them.
        dependencies = Property()
        while len(intersection_lib.sources) > 0:

            # Take one random source and find library for it.
            source = intersection_lib.sources.pop()
            found_library = find_library_including_source(source, lib_descs)

            if found_library == None:
                print("WARNING: library not found for: " + source)
            else:
                dependencies.add_item(found_library[0], Access.PUBLIC)
                intersection_lib.difference_update(found_library[1].library)

        # Update library's dependencies:
        lib_desc.library.set_prop(LibraryProperty.DEPENDENCIES, dependencies)

    # Info about success
    print("\nDependency generation finished!")


# Parse arguments
parser = argparse.ArgumentParser()
parser.add_argument("--examples", required=True)
parser.add_argument("--libraries", nargs='+', required=True)
parser.add_argument("--output", required=True)
args = parser.parse_args()

examples_filepath: str = args.examples
libraries_filepaths: List[str] = args.libraries
output_filepath: str = args.output

# List of all examples with sources, includes etc.
all_examples = examples_load_from_file(examples_filepath)

# Load defined libraries
all_libraries: Dict[str, LibraryDescription] = {}
for filepath in libraries_filepaths:
    all_libraries.update(libraries_load_from_file(filepath))

# Generates libraries
gen_libraries = generate_libraries(all_examples, all_libraries)
all_libraries.update(gen_libraries)

# Generate dependencies
generate_libraries_dependencies(all_examples, all_libraries)

# Convert libraries to JSON and save to ouptut file
libraries_save_to_file(output_filepath, all_libraries)
