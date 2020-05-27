#!/bin/bash

source "${BASH_SOURCE%/*}/consts.sh"
source "${BASH_SOURCE%/*}/check_deps.sh"
source "${BASH_SOURCE%/*}/utils.sh"

# Builds standalone library, following arguments are required:
function build_library() {
    if [[ $# -lt 4 ]]; then
        echo "Expected 4-5 arguments:"
        echo "1) library name, e.g.: nrf5_app_timer as defined in CMake files"
        echo "2) nRF SDK version, e.g.: 15.3.0"
        echo "3) board symbol, e.g.: pca10040, pca10056"
        echo "4) SoftDevice variant e.g.: s112, s132, s140, blank"
        echo "5) toolchain (optional), e.g.: gcc [default]"
        return 1
    fi

    local library_name=$1
    local sdk_version=$2
    local board_symbol=$3
    local sd_variant=$4
    local toolchain=${5:-gcc}

    local library_dir="$LIBRARIES_TESTS_DIR/$library_name"
    local toolchain_dir="$TOOLCHAINS_DIR/$toolchain"

    # Verify library path
    if [[ ! -d "$library_dir" ]]; then
        echo "Invalid library, $library_dir not found."
        return 1
    fi
    
    # Verify toolchain
    if [[ ! -d "$toolchain_dir" ]]; then
        echo "Toolchain $toolchain_dir not found."
        return 1
    fi

    # Get build command
    local build_cmd="make -j4"
    local build_type="Unix Makefiles"

    if [[ ! -z $(which ninja) ]]; then
        build_cmd="ninja"
        build_type="Ninja"
    fi

    # Check linker file
    local linker_file=$(find ${library_dir} -name "*.ld")

    # Prepare build folder
    local cmake_build_path="$BUILD_DIR/$sdk_version/$library_name/$board_symbol/$sd_variant/$toolchain"
    mkdir -p "$cmake_build_path" || {
        echo "Failed to create build directory $cmake_build_path, error code: $?"
        return 1
    }

    echo -e "\n${HEADER_START} ######## Building $cmake_build_path ######## ${HEADER_END}\n"

    # Call cmake with proper params
    # NOTE: CMake on Windows expects mixed path (Windows path with normal slashes)
    cmake \
        -S $(adapt_cmake_path $library_dir) \
        -B $(adapt_cmake_path $cmake_build_path) \
        -DCMAKE_TOOLCHAIN_FILE="$(adapt_cmake_path $CMAKE_DIR/arm-none-eabi.cmake)" \
        -DTOOLCHAIN_PREFIX="$(adapt_cmake_path $toolchain_dir)" \
        -DNRF5_SDK_PATH="$(adapt_cmake_path $SDKS_DIR/$sdk_version)" \
        -DNRF5_BOARD="$board_symbol" \
        -DNRF5_SOFTDEVICE_VARIANT="$sd_variant" \
        -DNRF5_LINKER_SCRIPT="$(adapt_cmake_path $linker_file)" \
        -DNRF5_SDKCONFIG_PATH="$(adapt_cmake_path $library_dir)" \
        -G "$build_type" || {
            echo "Failed to configure project with CMake"
            return 1
        }

    # Move to the build directory
    pushd "$cmake_build_path" > /dev/null
        $build_cmd || {
            echo "Failed to build"
            popd > /dev/null
            return 1
        }
    popd > /dev/null
}
