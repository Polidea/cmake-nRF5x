#!/usr/bin/env python3

from pathlib import Path
from nrf5_cmake.version import Version
import sys
import re
import argparse

from typing import List, Optional
from nrf5_cmake.example import Example
from nrf5_cmake.example_operations import examples_save_to_file


def find_main_c_file(path: str) -> Optional[str]:
    root = Path(path)
    while not root.is_dir() or not root.joinpath("main.c").exists():
        root = root.parent
        if root == Path("/"):
            return None
    return str(root)


def process_example(file_path: str, examples: List[Example]):
    with open(file_path, 'r') as file:

        # Make sure that main.c file exists for an example.
        main_c_file_dir = find_main_c_file(file_path)
        if main_c_file_dir == None:
            return

        # Load file content
        content = file.read()

        # File data
        file_local_path = \
            re.sub(r"\S+\/[0-9]+\.[0-9]\.[0-9]\/", "", main_c_file_dir)
        file_sdk_version = \
            re.findall(r"\/([0-9]+\.[0-9]\.[0-9])\/", file_path)[0]
        file_sources = set()
        file_includes = set()
        file_cflags = set()
        file_asmflags = set()
        file_ldflags = set()

        # Remove comments
        content = re.sub(r"#.*\n", "", content)

        # Find all sources (first regexp find SRC_FILES += .. \ .. \.. block, second extracts path)
        for sources in re.findall(r"SRC_FILES[ \t]*\+=(?:(?:[ \t]*\\[ \t]*\n)|(?:[ \t]*\S+[ \t]*(?:\\[ \t]*\n)?))+", content):
            sources = re.findall(r"\$\(SDK_ROOT\)\/(\S+)", sources)
            file_sources.update(sources)

        # Find all includes (first regexp find SRC_FILES += .. \ .. \.. block, second extracts path)
        for includes in re.findall(r"INC_FOLDERS[ \t]*\+=(?:(?:[ \t]*\\[ \t]*\n)|(?:[ \t]*\S+[ \t]*(?:\\[ \t]*\n)?))+", content):
            includes = re.findall(r"\$\(SDK_ROOT\)\/(\S+)", includes)
            file_includes.update(includes)

        # Find all c flags
        for cflags in re.findall(r"CFLAGS[ \t]*\+=(?:(?:[ \t]*\\[ \t]*\n)|(?:[ \t]*\S+[ \t]*(?:\\[ \t]*\n)?))+", content):
            cflags = re.findall(r"-\S+", cflags)
            for cflag in cflags:
                file_cflags.update(cflag.split(","))

        # Find all asm flags
        for asmflags in re.findall(r"ASMFLAGS[ \t]*\+=(?:(?:[ \t]*\\[ \t]*\n)|(?:[ \t]*\S+[ \t]*(?:\\[ \t]*\n)?))+", content):
            asmflags = re.findall(r"-\S+", asmflags)
            for cflag in asmflags:
                file_asmflags.update(cflag.split(","))

        # Find all ld flags
        for ldflags in re.findall(r"LDFLAGS[ \t]*\+=(?:(?:[ \t]*\\[ \t]*\n)|(?:[ \t]*\S+[ \t]*(?:\\[ \t]*\n)?))+", content):
            ldflags = re.findall(r"-\S+", ldflags)
            for cflag in ldflags:
                file_ldflags.update(cflag.split(","))

        examples.append(Example(
            path=file_path,
            local_path=file_local_path,
            sdk_version=Version.from_string(file_sdk_version),
            sources=file_sources,
            includes=file_includes,
            cflags=file_cflags,
            asmflags=file_asmflags,
            ldflags=file_ldflags
        ))


# Parse arguments
parser = argparse.ArgumentParser()
parser.add_argument("--output")
args = parser.parse_args()

# Scrape examples
examples: List[Example] = []
for line in sys.stdin.readlines():
    paths = line.split(" ")
    for path in paths:
        file_path = path.strip()
        if file_path != '':
            process_example(file_path, examples)

# Save them to a file
examples_save_to_file(args.output, examples)
