#!/bin/bash

HEADER_START="\033[1m"
HEADER_END="\033[0m"

# Get absolute path of a dir
function absolute() {
    pushd $1 > /dev/null
    pwd -P
    popd > /dev/null
}

# On Windows (Cygwin), convert Cygwin path to mixed path (Windows path with normal slashes)
function adapt_cmake_path() {
    if [[ "$OSTYPE" == "cygwin" ]]; then
        cygpath -m $1
    else
        echo $1
    fi
}
