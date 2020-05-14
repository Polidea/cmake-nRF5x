#!/bin/bash

source "${BASH_SOURCE%/*}/consts.sh"

# Validate all progams used in the scripts
function check_binary() {
    for binary in "$@"; do
        local binary_path=$(which $binary)
        if [[ -z $binary_path ]]; then
            echo "* $binary - missing"
        else 
            echo "* $binary - $binary_path"
            return 0
        fi
    done
    exit 1
}

echo "Checking binary dependencies:"
check_binary chmod
check_binary curl
check_binary tar
check_binary unzip
check_binary cmake
check_binary $PY3_EXE
check_binary $PIP3_EXE
check_binary ninja make