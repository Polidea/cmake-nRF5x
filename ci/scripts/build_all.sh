#!/bin/bash

source "${BASH_SOURCE%/*}/common/consts.sh"
source "${BASH_SOURCE%/*}/common/build.sh"

# Collect relative paths to the examples.
examples_dirs=()
pushd "$EXAMPLES_DIR" > /dev/null
    for example in `find . -name "CMakeLists.txt"`; do
        examples_dirs+=(`dirname $example`)
    done
popd > /dev/null

# Applying examples to included SDKs
echo "Applying examples for:"
for sdk in `ls -d $SDKS_DIR/*/`; do
    sdk_version=`basename $sdk`
    # For each SDK, try to apply examples
    for example in "${examples_dirs[@]}"; do
        # For each varaint
        for variant in $(ls "$EXAMPLES_DIR/$example"); do
            if [[ $variant =~ $VARIANT_REGEXP ]]; then
                build_example "$example" "$sdk_version" "$variant"
            fi
        done
    done
done


