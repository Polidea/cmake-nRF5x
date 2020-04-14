#!/bin/bash

source "${BASH_SOURCE%/*}/check_deps.sh"

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
    local nrf5_base_url="https://www.nordicsemi.com/-/media/Software-and-other-downloads/SDKs/nRF5/Binaries"

    # Expected two args
    if [[ $# != 2 ]]; then
        echo "Expected two arguments, SDK version and filepath."
        return 1
    fi

    # Validate first verion arg.
    local arg_regexp="[0-9]+\.[0-9]+.[0-9]+"
    if [[ !($1 =~ $arg_regexp) ]]; then
        echo "Expected nRF5 SDK version X.X.X, got: $1"
        return 1
    fi

    # Get proper suffix for SDK version.
    case $1 in
        "15.3.0") local nrf_suffix="nRF5SDK153059ac345.zip";;
        "16.0.0") local nrf_suffix="nRF5SDK160098a08e2.zip";;
        *) echo "nRF5 SDK $1 not supported!" && return 1;;
    esac

    # Prepare dirs.
    mkdir -p "$2"

    # Download file 
    echo "Downloading nRF5 SDK $1..."
    curl "$nrf5_base_url/$nrf_suffix" > "$2.zip" || {
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
            local arm_gcc_url="https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-mac.tar.bz2"
            local arm_gcc_outfile="$1.tar.bz2"
        };;
        linux-gnu) {
            echo "Downloading ARM GCC for Linux..."
            local arm_gcc_url="https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2"
            local arm_gcc_outfile="$1.tar.bz2"
        };;
        cygwin) {
            echo "Downloading ARM GCC for Windows (Cygwin)..."
            local arm_gcc_url="https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-win32.zip"
            local arm_gcc_outfile="$1.zip"
        };;
        *) {
            echo "'$OSTYPE' OS is not supported."
            return 1
        };;
    esac

    # Prepare directory
    mkdir -p "$1"

    # Download toolchain
    curl "$arm_gcc_url" > "$arm_gcc_outfile" || {
        echo "Failed to download GCC toolchain"
        return 1
    }

    # Unzip toolchain
    echo "Extracting GCC toolchain..."

    # Use appropriate tool depending on the type of the archive
    local arm_gcc_archive_type="${arm_gcc_outfile#*.}" 
    case $arm_gcc_archive_type in
        tar.bz2) tar -xf "$arm_gcc_outfile" -C "$1";;
        zip) unzip -q "$arm_gcc_outfile" "-d$1";;
        *) {
            echo "Unsupported toolchain archive type '$arm_gcc_archive_type'"
            return 1
        };;
    esac

    if [[ $? -ne 0 ]]; then
        echo "Failed to extract GCC toolchain"
        return 1
    fi

    # Merge folders
    merge_folders_inside "$1" || {
        echo "Failed to merge folder $1"
        return 1
    }

    # Remove file
    rm "$arm_gcc_outfile"
}

# Download nRF tools.
# 1) Directory where tools should be put.
function download_nrf_tools() {
    # Expect one argument
    if [[ $# != 1 ]]; then
        echo "Expected one argument, directory where to place tools."
        return 1
    fi

    # Select binary based on the OS type.
    case $OSTYPE in
        darwin*) {
            echo "Downloading nRF Tools for Mac OS..."
            local nrf_tools_url="https://www.nordicsemi.com/-/media/Software-and-other-downloads/Desktop-software/nRF-command-line-tools/sw/Versions-10-x-x/10-7-0/nRF-Command-Line-Tools_10_7_0_OSX.tar"
            local file_type="tar"
            local file_variant="mac"
        };;
        linux-gnu) {
            echo "Downloading nRF Tools for Linux..."
            local nrf_tools_url="https://www.nordicsemi.com/-/media/Software-and-other-downloads/Desktop-software/nRF-command-line-tools/sw/Versions-10-x-x/10-7-0/nRFCommandLineTools1070Linuxamd64tar.gz"
            local file_type="tar.gz"
            local file_variant="linux"
        };;
        *) {
            echo "'$OSTYPE' OS is not supported."
            return 1
        };;
    esac

    # Prepare directory
    mkdir -p "$1"

    # Download tools
    curl "$nrf_tools_url" --output "$1.$file_type" || {
        echo "Failed to download nRF tools"
        return 1
    }

    # Unzip tools
    echo "Extracting nRF tools..."
    case $file_variant in
        "mac") {
            echo "Executing Mac specific steps..."
            mkdir -p "$1/tmp"
            tar -xf "$1.$file_type" -C "$1/tmp"
            local inner_archive=$(find . -name "nRF*Command*Line*.tar")
            tar -xf "$inner_archive" -C "$1"
            rm -rf "$1/tmp"
        };;
        "linux") {
            echo "Executing Linux specific steps..."
            mkdir -p "$1/tmp"
            tar -xzf "$1.$file_type" -C "$1/tmp"
            local inner_archive=$(find . -name "nRF*Command*Line*.tar.gz")
            tar -xzf "$inner_archive" -C "$1"
            rm -rf "$1/tmp"
        };;
        *) {
            echo "Extracting for variant $file_variant not supported"
            return 1
        };;
    esac

    # Merge folders
    merge_folders_inside "$1" || {
        echo "Failed to merge folder $1"
        return 1
    }

    # Check if proper directories are there as expected
    if [[ ! -d $NRFJPROG_DIR ]]; then
        echo "Extracting failed, cannot find nrfjprog..."
        rm -rf $1
        return 1
    fi

    if [[ ! -d $MERGEHEX_DIR ]]; then
        echo "Extracting failed, cannot find mergehex..."
        rm -rf $1
        return 1
    fi

    # Remove file
    rm "$1.$file_type"
}
