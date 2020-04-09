#!/bin/bash

# Get absolute path of a dir
function absolute() {
    pushd $1 > /dev/null
    pwd -P
    popd > /dev/null
}
