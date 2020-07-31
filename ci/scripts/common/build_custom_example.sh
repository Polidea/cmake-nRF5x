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

function build_custom_example() {
    if [[ $# -lt 4 ]]; then
        echo "Expected 4-8 arguments:"
        echo "1) path to the example, e.g.: dfu/open_bootloader_usb as visible in ci/examples_custom"
        echo "2) nRF SDK version, e.g.: 16.0.0"
        echo "3) board symbol, e.g.: pca10040, pca10056"
        echo "4) SoftDevice variant e.g.: blank, s112, s140, mbr"
        echo "5) toolchain (optional), e.g.: gcc [default]"
        echo "6) build directory (optional)"
        echo "7) CMake log level (optional), e.g.: STATUS, WARNING, FATAL_ERROR"
        echo "8) flags (optional), e.g. clean"
        return 1
    fi

    local example_local_dir=$1
    local sdk_version=$2
    local board=$3
    local sd_variant=$4
    local toolchain=${5:-gcc}
    local build_dir=$6
    local log_level=$7
    local flags=$8

    local repo_example_dir="$CUSTOM_EXAMPLES_DIR/$example_local_dir"
    local configs_file="$repo_example_dir/configs.json"
    local sdk_dir="$SDKS_DIR/$sdk_version"
    local toolchain_dir="$TOOLCHAINS_DIR/$toolchain"

    # Verify example path
    if [[ ! -d "$repo_example_dir" ]]; then
        echo "Invalid example, $repo_example_dir not found."
        return 1
    fi

    # Check for the non-custom example duplicate
    if [[ -d "$EXAMPLES_DIR/$example_local_dir" ]]; then
        echo "'$example_local_dir' example found in ci/examples. Duplicates are forbidden."
        return 1
    fi

    # Verify configs.json file is present
    if [[ ! -f $configs_file ]]; then
        echo "No configs.json file in the example directory"
        return 1
    fi

    # Verify if the selected configuration is supported
    local config_obj=$(cat $configs_file | jq ".$board.$sd_variant")
    
    if [[ $config_obj == "null" ]]; then
        echo "'$board/$sd_variant' configuration is not supported by the '$example_local_dir' example"
        return 1
    fi

    # Verify sdk_config.h and linker script files
    local local_sdk_config_path=$(echo $config_obj | jq -r ".sdk_config_path")
    local local_linker_file=$(echo $config_obj | jq -r ".linker_script")

    if [[ $local_sdk_config_path == "null" || $local_linker_file == "null" ]]; then
        echo "Missing required keys in the '$board/$sd_variant' configuration in the example's configs.json"
        return 1
    fi

    # Verify if sdk_config.h exists
    local sdk_config_path="$sdk_dir/$local_sdk_config_path"
    
    if [[ ! -f "$sdk_config_path/sdk_config.h" ]]; then
        echo "sdk_config.h not found in $sdk_config_path"
        return 1
    fi

    # Verify if linker file exists
    local linker_file="$sdk_dir/$local_linker_file"

    if [[ ! -f "$linker_file" ]]; then
        echo "Linker file $linker_file does not exist"
    fi

    # Verify toolchain
    if [[ ! -d "$toolchain_dir" ]]; then
        echo "Toolchain $toolchain_dir not found."
        return 1
    fi

    # Prepare build folder
    local cmake_build_path="$BUILD_DIR/$sdk_version/$example_local_dir/$board/$sd_variant/$toolchain"
    if [[ ! -z $build_dir ]]; then
        # Use custom build path if specified
        cmake_build_path="$build_dir/$sdk_version/$example_local_dir/$board/$sd_variant/$toolchain"
    fi

    mkdir -p "$cmake_build_path" || {
        echo "Failed to create build directory $cmake_build_path, error code: $?"
        return 1
    }

    # Verify log level
    if [[ -z $log_level ]]; then
        # Use default if not specified
        log_level="STATUS"
    fi

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
        -DNRF5_SDK_PATH="$(adapt_cmake_path $sdk_dir)" \
        -DNRF5_BOARD="$board" \
        -DNRF5_SOFTDEVICE_VARIANT="$sd_variant" \
        -DNRF5_SDKCONFIG_PATH="$(adapt_cmake_path $sdk_config_path)" \
        -DNRF5_LINKER_SCRIPT="$(adapt_cmake_path $linker_file)" \
        -G "$build_type" \
        --loglevel="$log_level" || {
            echo "Failed to configure project with CMake"
            return 1
        }
    
    # Move to the build directory
    pushd "$cmake_build_path" > /dev/null
        if [[ "${flags[@]}" =~ [[:\<:]]clean[[:\>:]] ]]; then
            $build_cmd clean
        fi

        # Build the example
        $build_cmd || {
            echo "Failed to build with $build_type"
            popd > /dev/null
            return 1
        }
    popd > /dev/null
}
