#!/bin/bash

source "${BASH_SOURCE%/*}/common/build_library.sh"

sdk_versions=()

if [[ $# -gt 0 ]]; then
    # Build libraries for the passed SDK versions
    for sdk_ver in "$@"; do
        # Check if passed SDK versions are correct and present
        if [[ ! -d "$SDKS_DIR/$sdk_ver" ]]; then
            echo "nRF SDK $sdk_ver not found in $SDKS_DIR"
            exit 1
        fi
        sdk_versions+=( $sdk_ver )
    done
else
    # With no arguments passed, build libraries for all SDK version present
    for sdk_ver in `ls -d $SDKS_DIR/*/`; do
        sdk_versions+=( `basename $sdk_ver` )
    done
fi

if [[ ${#sdk_versions[@]} -eq 0 ]]; then
    echo "No nRF SDK found in $SDKS_DIR. Build terminated."
    exit 1
fi

echo "Building libraries for SDK versions: ${sdk_versions[@]}"

# Collect all libraries
libraries_dirs="$(ls -d ${LIBRARIES_TESTS_DIR}/*/)"

# Applying libraries to included SDKs
for sdk_ver in "${sdk_versions[@]}"; do
    # For each SDK, compile library
    for library_dir in $libraries_dirs; do
        library_name=$(basename $library_dir)

        build_library $library_name $sdk_ver pca10056 s140 || {
            echo "Failed to build: $library_name"
            exit 1
        }
    done
done
