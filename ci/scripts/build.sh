#!/bin/bash

# Include
source "$(dirname $0)/functions/utils.sh"
source "$(dirname $0)/functions/consts.sh"

# Functions --------------------------------------------------------------------

# This function prepares example by copying proper files to nRF SDK.
# 1) SDK's example dir
# 2) repo's example dir
function prepare_example() {
    # Check number of arguments.
    if [[ $# != 2 ]]; then
        echo "Expected two arguments, SDK's example dir, repo's example dir"
        return 1
    fi

    # Check local variables
    local sdk_example_dir=$1
    local repo_example_dir=$2

    if [[ ! -d "$sdk_example_dir" ]]; then
        echo "Expected SDK's example dir, got: $sdk_example_dir"
        return 1
    fi 

    if [[ ! -d "$repo_example_dir" ]]; then
        echo "Expected repo's example dir, got: $repo_example_dir"
        return 1
    fi 

    # Copy required files to the SDK.
    cp -r "$repo_example_dir"/* "$sdk_example_dir" || {
        echo "Failed to copy example files from $repo_example_dir to $sdk_example_dir"
        return 1
    }
}

# Function build example based on the following arguments:
# 1) SDK's example dir
# 2) Board version
# 3) Softdevice version
function build_example() {
    local example_dir=$1
    local board_version=$2
    local sd_version=$3
    echo "Building board: $board_version, sd: $sd_version..."
    
    # TODO: Fill with CMake calls...
}

# High level function, which prepares example, checks required builds and 
# executes them.
# 1) nRF version
# 2) example's relative directory
function process_example() {
    local nrf_version=$1
    local example_rel_dir=$2

    local repo_example_dir="$EXAMPLES_DIR/$example_rel_dir"
    local sdk_example_dir="$SDKS_DIR/$nrf_version/examples/$example_rel_dir"

    prepare_example "$sdk_example_dir" "$repo_example_dir" || {
        echo "Failed to prepare example for build process"
        return 1
    }

    for variant_path in `ls -d $sdk_example_dir/*/`; do
        local variant="$(basename $variant_path)"
        local variant_regexp="(pca[0-9]{5})_(s[0-9]{3})"
        if [[ ! $variant =~ $variant_regexp ]]; then
            continue
        fi

        local pca_variant="${BASH_REMATCH[1]}"
        local sd_variant="${BASH_REMATCH[2]}"
        build_example "$sdk_example_dir" "$pca_variant" "$sd_variant"
    done
}

# Entry point ------------------------------------------------------------------

# Collect relative paths to the examples.
EXAMPLES_DIRS=()
pushd $EXAMPLES_DIR > /dev/null
    for example in `find . -name "CMakeLists.txt"`; do
        EXAMPLES_DIRS+=(`dirname $example`)
    done
popd > /dev/null

# Applying examples to included SDKs
echo "Applying examples for:"
for sdk in `ls -d $SDKS_DIR/*/`; do
    sdk_version=`basename $sdk`

    # For each SDK, try to apply examples
    echo "* $sdk_version"
    for example in "${EXAMPLES_DIRS[@]}"; do
        echo "- $example"

        # Process example
        process_example $sdk_version $example || {
            echo "failed to process example"
            continue
        }

        # Example finished successfully
        echo "finished successfully!"
    done
done


