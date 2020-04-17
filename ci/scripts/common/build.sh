#!/bin/bash

source "${BASH_SOURCE%/*}/consts.sh"
source "${BASH_SOURCE%/*}/check_deps.sh"
source "${BASH_SOURCE%/*}/utils.sh"

if [[ -d $NRFJPROG_DIR ]]; then
    echo "* nrfjprog - using intree"
else
    check_binary nrfjprog
fi

if [[ -d $MERGEHEX_DIR ]]; then
    echo "* mergehex - using intree"
else
    check_binary mergehex
fi

# Builds an example, following arguments are required:
# 1) local path to the example
# 2) nRF SDK version
# 3) prefix of build variant
# 4) toolchain
function build_example() {
    if [[ $# -lt 3 ]]; then
        echo "Expected 3-4 arguments:"
        echo "1) local path to the example, e.g.: peripheral/blinky as visible in nRF SDK"
        echo "2) nRF SDK version, e.g.: 15.3.0"
        echo "3) prefix of build variant, e.g.: pca10028"
        echo "4) toolchain, e.g.: gcc [default]"
        return 1
    fi

    local example_local_dir=$1
    local sdk_version=$2
    local build_variant=$3
    local toolchain=${4:-gcc}

    local repo_example_dir="$EXAMPLES_DIR/$example_local_dir"
    local sdk_example_dir="$SDKS_DIR/$sdk_version/examples/$example_local_dir"
    local toolchain_dir="$TOOLCHAINS_DIR/$toolchain"

    # Verify example path
    if [[ ! -d "$repo_example_dir" ]]; then
        echo "Invalid example, $repo_example_dir not found."
        return 1
    fi

    # Verify SDK is present.
    if [[ ! -d "$sdk_example_dir" ]]; then
        echo "Example in SDK $sdk_example_dir not available."
        return 1
    fi

    # Verify build variant.
    local example_dirs=$(ls -d $repo_example_dir/*/)
    local selected_variant
    local pca_variant
    local sd_variant

    for dir in $example_dirs; do
        local dir_name=$(basename $dir)
        if [[ $dir_name =~ $build_variant.* && $dir_name =~ $VARIANT_REGEXP ]]; then
            selected_variant="$dir_name"
            pca_variant="${BASH_REMATCH[1]}"
            sd_variant="${BASH_REMATCH[2]}"
            break
        fi
    done

    if [[ -z $selected_variant ]]; then
        echo "Build variant $build_variant not found"
        return 1
    fi

    # Verify toolchain
    if [[ ! -d "$toolchain_dir" ]]; then
        echo "Toolchain $toolchain_dir not found."
        return 1
    fi

    # Copy files from example folder to example in SDK dir.
    cp -r "$repo_example_dir"/* "$sdk_example_dir" || {
        echo "Failed to copy example files from $repo_example_dir to $sdk_example_dir"
        return 1
    }

    # Validate linker file
    local linker_file
    for file in $(ls $sdk_example_dir/$selected_variant); do
        if [[ $file =~ .*\.ld ]]; then
            linker_file="$file"
            break
        fi
    done
    if [[ -z $linker_file ]]; then
        echo "Didn't find linker file inside $selected_variant variant..."
        return 1
    fi

    # Prepare build folder
    local cmake_build_path="$BUILD_DIR/$sdk_version/$example_local_dir/$selected_variant/$toolchain"
    mkdir -p "$cmake_build_path"
    echo -e "\n${HEADER_START} ######## Building $cmake_build_path ######## ${HEADER_END}\n"

    # Get path to tools
    local nrfjprog="nrfjprog"
    if [[ -d $NRFJPROG_DIR ]]; then
        nrfjprog="$NRFJPROG_DIR/nrfjprog"
    fi

    # Get build command
    local build_cmd="make -j4"
    local build_type="Unix Makefiles"

    if [[ ! -z $(which ninja) ]]; then
        build_cmd="ninja"
        build_type="Ninja"
    fi

    # Call cmake with proper params
    # NOTE: CMake on Windows expects mixed path (Windows path with normal slashes)
    cmake \
        -S $(adapt_cmake_path $sdk_example_dir) \
        -B $(adapt_cmake_path $cmake_build_path) \
        -DNRF5_NRFJPROG="$(adapt_cmake_path $nrfjprog)" \
        -DCMAKE_BUILD_TYPE=Debug \
        -DCMAKE_TOOLCHAIN_FILE="$(adapt_cmake_path $CMAKE_DIR/arm-none-eabi.cmake)" \
        -DTOOLCHAIN_PREFIX="$(adapt_cmake_path $toolchain_dir)" \
        -DNRF5_SDK_PATH="$(adapt_cmake_path $SDKS_DIR/$sdk_version)" \
        -DNRF5_BOARD="$pca_variant" \
        -DNRF5_LINKER_SCRIPT="$(adapt_cmake_path $sdk_example_dir/$selected_variant/$linker_file)" \
        -DNRF5_SDKCONFIG_PATH="$(adapt_cmake_path $sdk_example_dir/$selected_variant)" \
        --loglevel=WARNING \
        -G "$build_type" || {
            echo "Failed to configure project with CMake"
            return 1
        }

    # Move to the build directory
    pushd "$cmake_build_path" > /dev/null
        $build_cmd || {
            echo "Failed to build with ninja"
            popd > /dev/null
            return 1
        }
    popd > /dev/null
}
