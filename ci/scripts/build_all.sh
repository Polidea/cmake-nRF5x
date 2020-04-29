#!/bin/bash

set -e

source "${BASH_SOURCE%/*}/common/build.sh"

function build_all_configs() {
    local example=$1
    local sdk_version=$2
    local toolchain=$3
    local config_dir=$4
    local build_dir=$5

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
            build_example $example $sdk_version $board $sd_variant $toolchain $config_dir $build_dir || exit 1
        done
    done

    return 0
}

sdk_versions=()

if [[ $# -gt 0 ]]; then
    # Build examples for the passed SDK versions
    for sdk_ver in "$@"; do
        # Check if passed SDK versions are correct and present
        if [[ ! -d "$SDKS_DIR/$sdk_ver" ]]; then
            echo "nRF SDK $sdk_ver not found in $SDKS_DIR"
            exit 1
        fi
        sdk_versions+=( $sdk_ver )
    done
else
    # With no arguments passed, build examples for all SDK version present
    for sdk_ver in `ls -d $SDKS_DIR/*/`; do
        sdk_versions+=( `basename $sdk_ver` )
    done
fi

if [[ ${#sdk_versions[@]} -eq 0 ]]; then
    echo "No nRF SDK found in $SDKS_DIR. Build terminated."
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
            build_all_configs $example $sdk_ver "gcc" "$EXAMPLES_DIR/$example/config" "$BUILD_DIR/local"
        fi

        # Build all configs in the SDK example directory
        build_all_configs $example $sdk_ver "gcc" "$SDKS_DIR/$sdk_ver/examples/$example"
    done
done
