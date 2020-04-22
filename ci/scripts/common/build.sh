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

    # Verify if the specified build variant is supported by the example.
    local build_variant_dir="$sdk_example_dir/$build_variant"

    if [[ ! -d $build_variant_dir ]]; then
            echo "'$build_variant' build variant is incorrect or not supported by the '$example_local_dir' example"
        return 1
    fi

    # Determine SoftDevice variant for the specified build variant (board).
    local supported_sd_variant_dirs=($(ls -d $build_variant_dir/s* 2> /dev/null))

    if [[ ${#supported_sd_variant_dirs[@]} -eq 0 ]]; then
        echo "'$example_local_dir' for the '$build_variant' is not available in SoftDevice configuration. Non-SoftDevice builds are currently not supported. Build skipped."
        exit 0
    elif [[ ${#supported_sd_variant_dirs[@]} -gt 1 ]]; then
        echo "WARNING: Multiple SoftDevice configurations available for '$build_variant' in the '$example_local_dir' example."
    fi

    local sd_variant_dir=${supported_sd_variant_dirs[0]}
    local sd_variant=$(basename $sd_variant_dir)
    local pca_variant=$build_variant
    
    # Verify toolchain
    if [[ ! -d "$toolchain_dir" ]]; then
        echo "Toolchain $toolchain_dir not found."
        return 1
    fi

    # Find the linker script for the specified build and SoftDevice variant.
    local linker_file_list=($(ls $sd_variant_dir/armgcc/*.ld 2> /dev/null))
    local linker_file=${linker_file_list[0]}

    if [[ -z $linker_file ]]; then
        echo "Linker file for '$sd_variant' SoftDevice not found in $sd_variant_dir/armgcc"
        return 1
    fi

    # # Prepare build folder
    local cmake_build_path="$BUILD_DIR/$sdk_version/$example_local_dir/$build_variant/$toolchain"
    mkdir -p "$cmake_build_path"
    echo -e "\n${HEADER_START} ######## Building $cmake_build_path ######## ${HEADER_END}\n"

    # Get path to tools
    local nrfjprog=""
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
        -S $(adapt_cmake_path $repo_example_dir) \
        -B $(adapt_cmake_path $cmake_build_path) \
        -DNRF5_NRFJPROG="$(adapt_cmake_path $nrfjprog)" \
        -DCMAKE_BUILD_TYPE=Debug \
        -DCMAKE_TOOLCHAIN_FILE="$(adapt_cmake_path $CMAKE_DIR/arm-none-eabi.cmake)" \
        -DTOOLCHAIN_PREFIX="$(adapt_cmake_path $toolchain_dir)" \
        -DNRF5_SDK_PATH="$(adapt_cmake_path $SDKS_DIR/$sdk_version)" \
        -DNRF5_BOARD="$pca_variant" \
        -DNRF5_SOFTDEVICE_VARIANT="$sd_variant" \
        -DNRF5_LINKER_SCRIPT="$(adapt_cmake_path $linker_file)" \
        -DNRF5_SDKCONFIG_PATH="$(adapt_cmake_path $sd_variant_dir/config)" \
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
