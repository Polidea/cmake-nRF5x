#!/bin/bash

# Validate all progams used in the scripts
function check_binary() {
    local binary_path=$(which $1)
    if [[ -z $binary_path ]]; then
        echo "* $1 - missing"
        exit 1
    fi
    echo "* $1 - $binary_path"
}

echo "Checking binary dependencies:"
check_binary curl
check_binary tar
check_binary unzip
check_binary ninja
check_binary cmake