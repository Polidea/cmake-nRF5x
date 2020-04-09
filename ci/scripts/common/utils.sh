#!/bin/bash

HEADER_START="\033[1m"
HEADER_END="\033[0m"

# Get absolute path of a dir
function absolute() {
    pushd $1 > /dev/null
    pwd -P
    popd > /dev/null
}
