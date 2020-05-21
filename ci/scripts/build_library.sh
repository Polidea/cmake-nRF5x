#!/bin/bash

source "${BASH_SOURCE%/*}/common/build_library.sh"

function print_help() {
    echo "
    Usage:
    --------------------------------------------------------------------------------

    [Mandatory]

        --library=<library>         nRF5 library as defined in CMake files, e.g. nrf5_balloc

        --sdk_version=<version>     nRF SDK version, e.g. 15.3.0

        --board=<board>             Board symbol, e.g. pca10040, pca10056

        --sd_variant=<variant>      SoftDevice variant, e.g. s132, s140, blank

    [Optional]

        --toolchain=<toolchain>     Toolchain, e.g. gcc [default]
    "
    exit 0
}

function check_option() {
    if [[ $# -lt 2 ]] || [[ -z $1 ]]; then
        echo "Missing mandatory option \"--$1\", use \"--help\""
        exit 1 
    fi
}

library=""
sdk_version=""
board=""
sd_variant=""
toolchain="gcc"

while getopts ":h-:" opt; do
    case $opt in
        -) {
            # Handle long options ("--option=<arg>")
            case $OPTARG in
                library=*)
                    library=${OPTARG#*=} ;;
                sdk_version=*)
                    sdk_version=${OPTARG#*=} ;;
                board=*)
                    board=${OPTARG#*=} ;;
                sd_variant=*)
                    sd_variant=${OPTARG#*=} ;;
                toolchain=*)
                    toolchain=${OPTARG#*=} ;;
                help)
                    print_help ;;
                *) {
                    if [[ $OPTERR -eq 1 ]]; then
                        echo "Unknown option \"--$OPTARG\" or missing argument (use \"--option=<arg>\" syntax), use \"--help\""
                        exit 1
                    fi
                };;
            esac
        };;
        h) {
            print_help
        };;
        \?) {
            unknown_optind=$(($OPTIND - 1))
            unknown_opt=${!unknown_optind}
            echo "Uknown option \"$unknown_opt\""
            exit 1
        };;
    esac
done

# Check mandatory options
check_option "library" $library
check_option "sdk_version" $sdk_version
check_option "board" $board
check_option "sd_variant" $sd_variant

build_library $library $sdk_version $board $sd_variant $toolchain
