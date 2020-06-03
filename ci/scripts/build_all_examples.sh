#!/bin/bash

source "${BASH_SOURCE%/*}/common/build_example.sh"

# Ignored list of examples separated with semicolon.
build_ignore_config_list="pca10100_16.0.0"

function build_all_configs() {
    local example=$1
    local sdk_version=$2
    local toolchain=$3
    local config_dir=$4
    local build_dir=$5
    local log_level=$6

    if [[ ! -d $config_dir ]]; then
        echo "\"$config_dir\" is not a valid configuration directory"
        return 1
    fi

    # For each board
    for board_dir in `ls -d $config_dir/pca*`; do
        board=`basename $board_dir`

        # Identify SoftDevice variants available for the specified board (SoftDevice configurations only)
        supported_sd_variant_dirs=($(ls -d $board_dir/s* 2> /dev/null))

        if [[ ${#supported_sd_variant_dirs[@]} -eq 0 ]]; then
            echo "A SoftDevice configuration for the '$example' for the '$board' board is not available (config. dir.: $config_dir). Build skipped."
            continue
        fi

        # For each SDK variant
        for sd_variant_dir in ${supported_sd_variant_dirs[@]}; do
            sd_variant=`basename $sd_variant_dir`

            # Check if combination is ignored 
            if [[ $build_ignore_config_list =~ "${board}_${sdk_version}" ]]; then
                continue
            fi
            
            build_example "$example" "$sdk_version" "$board" "$sd_variant" "$toolchain" "$config_dir" "$build_dir" "$log_level" || exit 1
        done
    done

    return 0
}

function print_help() {
    # TODO: write help
    echo "Help!"
}

sdk_version_list=""
log_level="NOTICE"

while getopts ":h-:" opt; do
    case $opt in
        -) {
            # Handle long options ("--option=<arg>")
            case $OPTARG in
                sdk_versions=*)
                    sdk_version_list=${OPTARG#*=} ;;
                log_level=*) {
                    log_level=${OPTARG#*=} 
                    if [[ ! $log_level =~ $CMAKE_LOG_LEVEL_REGEXP ]]; then
                        echo "Invalid log level \"$log_level\" (available log levels: TRACE, DEBUG, VERBOSE, STATUS, NOTICE, WARNING, ERROR)"
                        exit 1
                    fi
                };;
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


sdk_versions=($sdk_version_list)

if [[ ${#sdk_versions[@]} -gt 0 ]]; then
    # Build examples for the passed SDK versions
    for sdk_ver in ${sdk_versions[@]}; do
        # Check if passed SDK versions are correct and present
        if [[ ! -d "$SDKS_DIR/$sdk_ver" ]]; then
            echo "nRF5 SDK $sdk_ver not found in $SDKS_DIR"
            exit 1
        fi
    done
else
    # With no arguments passed, build examples for all SDK version present
    for sdk_ver in `ls -d $SDKS_DIR/*/`; do
        sdk_versions+=( `basename $sdk_ver` )
    done
fi

if [[ ${#sdk_versions[@]} -eq 0 ]]; then
    echo "No nRF5 SDK found in $SDKS_DIR. Build terminated."
    exit 1
fi

echo "Building examples for SDK versions: ${sdk_versions[@]}"

# Collect relative paths to the examples.
example_local_dirs=()
pushd "$EXAMPLES_DIR" > /dev/null
    for example in `find . -name "CMakeLists.txt"`; do
        example_dir=`dirname $example`
        # Strip the '.' prefix (current directory) from the example directory
        example_local_dirs+=(${example_dir#./})
    done
popd > /dev/null

# Applying examples to included SDKs
for sdk_ver in "${sdk_versions[@]}"; do
    # For each SDK, try to apply examples
    for example in "${example_local_dirs[@]}"; do
        # Build all custom configs in the local example directory
        if [[ -d "$EXAMPLES_DIR/$example/config" ]]; then
            build_all_configs "$example" "$sdk_ver" "gcc" "$EXAMPLES_DIR/$example/config" "$BUILD_DIR/local" "$log_level"
        fi

        # Build all configs in the SDK example directory
        build_all_configs "$example" "$sdk_ver" "gcc" "$SDKS_DIR/$sdk_ver/examples/$example" "" "$log_level"
    done
done
