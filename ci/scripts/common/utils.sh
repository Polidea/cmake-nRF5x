#!/bin/bash

HEADER_START="\033[1m"
HEADER_END="\033[0m"

# Python executable names
if [[ "$OSTYPE" == "cygwin" ]]; then
    PY3_EXE="python3.8"
    PIP3_EXE="pip3.8"
else
    PY3_EXE="python3"
    PIP3_EXE="pip3"
fi

# Get absolute path of a dir
function absolute() {
    pushd $1 > /dev/null
    pwd -P
    popd > /dev/null
}

# On Windows (Cygwin), convert Cygwin path to mixed path (Windows path with normal slashes)
function adapt_cmake_path() {
    # Handle an empty path (so `cygpath` won't complain)
    if [[ -z "$1" ]]; then
        return 0
    fi

    if [[ "$OSTYPE" == "cygwin" ]]; then
        cygpath -m $1
    else
        echo $1
    fi
}

# Wrapper for calling python3
function invoke_py3() {
    eval $PY3_EXE $@
}

# Wrapper for calling pip3
function invoke_pip3() {
    eval $PIP3_EXE $@
}

function version_greater_equal() {
    local less=$(printf "$1\n$2" | sort | head -n1)

    if [[ $less == $2 ]]; then
        return 0
    else
        return 1
    fi
}
