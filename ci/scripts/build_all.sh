#!/bin/bash

source "${BASH_SOURCE%/*}/common/build.sh"

# Collect relative paths to the examples.
examples_dirs=()
pushd "$EXAMPLES_DIR" > /dev/null
    for example in `find . -name "CMakeLists.txt"`; do
        example_dir=`dirname $example`
        # Strip the '.' prefix (current directory) from the example directory
        examples_dirs+=(${example_dir#./})
    done
popd > /dev/null

# Applying examples to included SDKs
for sdk in `ls -d $SDKS_DIR/*/`; do
    sdk_version=`basename $sdk`
    # For each SDK, try to apply examples
    for example in "${examples_dirs[@]}"; do
        sdk_example_dir="$SDKS_DIR/$sdk_version/examples/$example"

        # For each varaint
        for variant_dir in `ls -d $sdk_example_dir/pca*`; do
            variant=`basename $variant_dir`
                build_example "$example" "$sdk_version" "$variant"
        done
    done
done
