sdk_path="D:/tools/nRF5SDK160098a08e2"
sdk_version="16.0.0"
example_name="dfu/open_bootloader"
example_dir="$sdk_path/examples/$example_name"
example_cfg="pca10056_usb_debug"
sd_variant="mbr"
build_dir="D:/workspace/nrf5-cmake/build"
cmake_build_path="$build_dir/$sdk_version/$example_name/$example_cfg/$sd_variant/gcc"

cmake \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_TOOLCHAIN_FILE=D:/workspace/nrf5-cmake/cmake/arm-none-eabi.cmake \
    -DTOOLCHAIN_PREFIX=D:/tools/gcc-arm-none-eabi-9-2019-q4-major-win32 \
    -DNRF5_SDK_PATH="$sdk_path" \
    -DNRF5_BOARD=pca10056 \
    -DNRF5_SOFTDEVICE_VARIANT="$sd_variant" \
    -DNRF5_SDKCONFIG_PATH="$example_dir/$example_cfg/config" \
    -DNRF5_LINKER_SCRIPT="$example_dir/$example_cfg/armgcc/open_bootloader_gcc_nrf52.ld" \
    -G "Ninja" \
    -B build \
    -S .
