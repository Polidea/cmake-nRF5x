#!/bin/bash

set -e

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
examples_dirs=()
pushd "$EXAMPLES_DIR" > /dev/null
    for example in `find . -name "CMakeLists.txt"`; do
        examples_dirs+=(`dirname $example`)
    done
popd > /dev/null

# Applying examples to included SDKs
for sdk_ver in "${sdk_versions[@]}"; do
    # For each SDK, try to apply examples
    for example in "${examples_dirs[@]}"; do
        # For each varaint
        for variant in $(ls "$EXAMPLES_DIR/$example"); do
            if [[ $variant =~ $VARIANT_REGEXP ]]; then
                build_example "$example" "$sdk_ver" "$variant" || exit 1
            fi
        done
    done
done
