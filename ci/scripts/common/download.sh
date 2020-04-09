#!/bin/bash

# Function moves content of subdirectories to provided directory
# 1) Current folder.
function merge_folders_inside() {
    # Check args
    if [[ $# != 1 ]]; then
        echo "Expected one argument, directory path"
        return 1
    fi

    # Move contents of directories to parent directory and remove them
    # only if there is one directory.
    local folders=($(ls -d $1/*/))

    if [[ ${#folders[@]} != 1 ]]; then
        echo "Skipping folder merging..."
        return 0
    fi

    for folder in ${folders[@]}; do
        echo "Moving contents of $1/$folder to $1..."
        mv "$folder"* "$1" || {
            echo "Failed to move subdirectory content"
            return 1
        }
        rmdir "$folder" || {
            echo "Failed to remove empty? folder"
            return 1
        }
    done
}

# Downloads nRF5 SDK from the internet.
# 1) nRF5 version in form "X.X.X"
# 2) Path of a downloaded file.
function download_sdk() {
    # Location where binary files are placed.
    local NRF5_BASE_URL="https://www.nordicsemi.com/-/media/Software-and-other-downloads/SDKs/nRF5/Binaries"

    # Expected two args
    if [[ $# != 2 ]]; then
        echo "Expected two arguments, SDK version and filepath."
        return 1
    fi

    # Validate first verion arg.
    local ARG_REGEXP="[0-9]+\.[0-9]+.[0-9]+"
    if [[ !($1 =~ $ARG_REGEXP) ]]; then
        echo "Expected nRF5 SDK version X.X.X, got: $1"
        return 1
    fi

    # Get proper suffix for SDK version.
    case $1 in
        "15.3.0") local NRF_SUFFIX="nRF5SDK153059ac345.zip";;
        "16.0.0") local NRF_SUFFIX="nRF5SDK160098a08e2.zip";;
        *) echo "nRF5 SDK $1 not supported!" && return 1;;
    esac

    # Prepare dirs.
    mkdir -p $2

    # Download file 
    echo "Downloading nRF5 SDK $1..."
    curl "$NRF5_BASE_URL/$NRF_SUFFIX" --output "$2.zip" || {
        echo "Failed to download nRF5 SDK $1"
        return 1
    }

    # Unzip file to a folder
    echo "Unzipping nRF SDK $1..."
    unzip -q "$2.zip" "-d$2" || {
        echo "Failed to unzip nRF5 SDK $1"
        return 1
    }

    # Remove all top folders
    merge_folders_inside "$2" || {
        echo "Failed to merge folder $2"
        return 1
    }

    # Remove zip file.
    rm "$2.zip"
}

# Download ARM GCC toolchain.
# 1) Directory where toolchain should be put.
function download_gcc_toolchain() {
    # Expect one argument
    if [[ $# != 1 ]]; then
        echo "Expected one argument, directory where to place toolchain."
        return 1
    fi

    # Select binary based on the OS type.
    case $OSTYPE in
        darwin*) {
            echo "Downloading ARM GCC for Mac OS..."
            local ARM_GCC_URL="https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-mac.tar.bz2"
        };;
        linux-gnu) {
            echo "Downloading ARM GCC for Linux..."
            local ARM_GCC_URL="https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2"
        };;
        *) {
            echo "'$OSTYPE' OS is not supported."
            return 1
        };;
    esac

    # Prepare directory
    mkdir -p $1

    # Download toolchain
    curl "$ARM_GCC_URL" --output "$1.tar.bz2" || {
        echo "Failed to download GCC toolchain"
        return 1
    }

    # Unzip toolchain
    echo "Extracting GCC toolchain..."
    tar -xzf "$1.tar.bz2" -C "$1"

    # Merge folders
    merge_folders_inside "$1" || {
        echo "Failed to merge folder $1"
        return 1
    }

    # Remove file
    rm "$1.tar.bz2"
}
