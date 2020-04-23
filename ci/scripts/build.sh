#!/bin/bash

source "${BASH_SOURCE%/*}/common/build.sh"

function check_option() {
    if [[ $# -lt 2 ]] || [[ -z $1 ]]; then
        echo "Missing mandatory option \"--$1\""
        return 1 
    fi
}

example=""
sdk_version=""
board=""
sd_variant=""
toolchain=""

while getopts ":-:" opt; do
    case $opt in
        -) {
            # Handle long options ("--option=<arg>")
            case $OPTARG in
                example=*)
                    example=${OPTARG#*=} ;;
                sdk_version=*)
                    sdk_version=${OPTARG#*=} ;;
                board=*)
                    board=${OPTARG#*=} ;;
                sd_variant=*)
                    sd_variant=${OPTARG#*=} ;;
                toolchain=*)
                    toolchain=${OPTARG#*=} ;;
                *) {
                    if [[ $OPTERR -eq 1 ]]; then
                        echo "Unknown option \"--$OPTARG\" or missing argument (use \"--option=<arg>\" syntax)"
                        exit 1
                    fi
                };;
            esac
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
check_option "example" $example
check_option "sdk_version" $sdk_version
check_option "board" $board
check_option "sd_variant" $sd_variant

build_example $example $sdk_version $board $sd_variant $toolchain
