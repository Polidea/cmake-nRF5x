# nRF5 CMake

This repository provides platform-agnostic CMake files that can be used to build
custom nRF5 projects. Our goal is to cover the most used libraries and examples
starting from nRF5 SDK version 15.3.0.

## How to use

Copy all CMake files from the `./cmake` folder located in this repository to
your project location and create a basic `CMakeLists.txt` file:

```cmake
cmake_minimum_required(VERSION 3.14)
project(blinky LANGUAGES C ASM)

include("nrf5")
add_executable(${CMAKE_PROJECT_NAME}
  "${NRF5_SDK_PATH}/examples/peripheral/blinky/main.c"
)

nrf5_target(${CMAKE_PROJECT_NAME})
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
  nrf5_nrfx_common
  nrf5_delay
  nrf5_boards
)
```

The above example compiles source from the SDK but the user is expected to copy
`main.c` and modify it instead. Below you can look at a very basic bash script,
which builds and flashes blinky example.

```bash
#!/bin/bash

# Generate project inside ./build folder.
cmake \
    -S . \
    -B build \
    -DCMAKE_TOOLCHAIN_FILE="./cmake/arm-none-eabi.cmake" \
    -DTOOLCHAIN_PREFIX="/Users/przemyslawlenart/git/nrf5-cmake/ci/toolchains/gcc" \
    -DNRF5_SDK_PATH="/Users/przemyslawlenart/git/nrf5-cmake/ci/sdks/16.0.0" \
    -DNRF5_BOARD="pca10056" \
    -DNRF5_SOFTDEVICE_VARIANT="s140"

# Build project
cmake --build build

# Erase all
cmake --build build --target erase_all

# Flash SoftDevice (if used)
cmake --build build --target flash_softdevice

# Flash progarm
cmake --build build --target flash
```

You can find more examples in the repo's [`./ci/examples/`](./ci/examples) folder.
Make sure to check all available cached variables, which are documented below
and read [Contributing readme](./ci/README.md) file if you plan to automate SDK
and tool downloads.

## Configuration

CMake files are configured with cached variables. A lot of them are optional and
can be deduced from other ones or SDK itself. Specify `-DNAME=VALUE` during
project generation to pass them.

### `CMAKE_TOOLCHAIN_FILE` (file path, requred)

Specifies a file path to the toolchain file which points to the ARM compiler
utilities. Currently, only GCC toolchain is supported and `arm-none-eabi.cmake`
file is included in `./cmake` folder, which you should copy to your project.

### `TOOLCHAIN_PREFIX` (directory path, optional)

Path to the directory containing GCC toolchain. If not specified, version
installed globally is used.

### `NRF5_SDK_PATH` (directory path, required)

Specifies a path to the nRF5 SDK, which should be used during compilation. Root
directory should include folders like `examples`, `components` etc.

### `NRF5_SDK_VERSION` (version string, optional)

You can explicily specify SDK version (e.g. `"16.0.0"`). When this cached
variable is not provided, version is deduced from the SDK file contents.

### `NRF5_BOARD` (board name, optional)

If you are using the nRF board you can specify it (e.g. `"pca10056"`) and the
value of `NRF5_TARGET` will be deduced accordingly. If defined, all
board-specific defines (like `-DBOARD_PCA10056`) are included for all source
files during compilation.

### `NRF5_TARGET` (target name, optional)

If `NRF5_BOARD` is not specified, this variable is required. You can use alias
value like `nrf52840`, but full target name is recommended: `nrf52840_xxaa`.
CMake file will deduce all chip specific flags during compilation for all
project sources (e.g. `"-mcpu=cortex-m4"`).

### `NRF5_SOFTDEVICE_VARIANT` (soft device name, required)

This variable specifies the SoftDevice binary. If the project doesn't require
SoftDevice you can pass `"blank"` value, otherwise set SoftDevice name
(e.g. `"s140"`). Following triple: (`NRF5_SDK_VERSION`, `NRF5_TARGET`,
`NRF5_SOFTDEVICE_VARIANT`) is then verified to check if the combination is well
supported. All SoftDevice related defines are included for all source files
(e.g. `"-DNRF_SD_BLE_API_VERSION=7"`). The `flash_softdevice` target should be
pointing to the correct SoftDevice file.

### `NRF5_SDKCONFIG_PATH` (directory path, optional)

It is highly recommended to specify a path to custom `"sdk_config.h"` file.
Otherwise, based on the above variables' values, the CMake file tries to find
the best matching file from the SDK. If you want to create a custom target which
depends on the config file, link `nrf5_config` dependency. All builtin libraries
are doing it by default.

### `NRF5_APPCONFIG_PATH` (directory path, optional)

If your project is using `app_config.h` you can provide include directory
pointing to this file.

### `NRF5_LINKER_SCRIPT` (file path, optional)

It is highly recommended to specify a path to custom linker file. Otherwise,
based on the above variables' values, the CMake file tries to find the best
matching file from the SDK.

### `NRF5_NRFJPROG` (executable file, optional)

Path to the `nrfjprog` executable used by targets flashing programs. If not
specified, globally installed binary is used.

### `NRF5_STACK_SIZE` (size in bytes, optional)

Defines `__STACK_SIZE` compile definition accordingly. If not passed, the
startup file (.S) will take care of setting up default stack boundaries for
the specified target.

### `NRF5_HEAP_SIZE` (size in bytes, optional)

Defines `__HEAP_SIZE` compile definition accordingly. If not passed, the
startup file (.S) will take care of setting up default heap boundaries for
the specified target.

## Contributing

The project is developed in a semi-automated way and thoroughly tested with CI
by compiling both SDK provided examples and libraries. You can find more
information about the project's setup, structure, scripts, etc. in
[`./ci/README.md`](./ci/README.md) file.

[Thank you!](https://github.com/Polidea/cmake-nRF5x/graphs/contributors)

## License

    MIT License

    Copyright (c) 2020 Polidea

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.

## Maintained by [Polidea](https://www.polidea.com/services/iot/)

[![Polidea](https://raw.githubusercontent.com/Polidea/RxAndroidBle/master/site/polidea_logo.png "Tailored software services including concept, design, development and testing")](http://www.polidea.com)
