#!/bin/bash

source "${BASH_SOURCE%/*}/common/build.sh"

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
for sdk in `ls -d $SDKS_DIR/*/`; do
    sdk_version=`basename $sdk`
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
                build_example "$example" "$sdk_version" "$board" "$sd_variant"
            done
        done
    done
done
