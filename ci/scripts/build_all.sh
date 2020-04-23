#!/bin/bash

source "${BASH_SOURCE%/*}/common/build.sh"

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
        sdk_example_dir="$SDKS_DIR/$sdk_version/examples/$example"

        # For each board
        for board_dir in `ls -d $sdk_example_dir/pca*`; do
            board=`basename $board_dir`

            # Identify SoftDevice variants available for the specified board (SoftDevice configurations only).
            supported_sd_variant_dirs=($(ls -d $board_dir/s* 2> /dev/null))

            if [[ ${#supported_sd_variant_dirs[@]} -eq 0 ]]; then
                echo "A SoftDevice configuration for the '$example' for the '$board' board is not available. Non-SoftDevice builds are currently not supported. Build skipped."
                continue
            fi

            # For each SDK variant
            for sd_variant_dir in ${supported_sd_variant_dirs[@]}; do
                sd_variant=`basename $sd_variant_dir`
                build_example "$example" "$sdk_version" "$board" "$sd_variant" || exit 1
            done
        done
    done
done
