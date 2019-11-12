# cmake-nRF5x

Cmake script for projects targeting Nordic Semiconductor nRF5x series devices using the GCC toolchain from ARM.

Tested on MacOS with nRF5x SDK 15.3.0.

## Dependencies

The script makes use of the following tools:

- nRF5x SDK by Nordic Semiconductor - SoC specific drivers and libraries (also includes a lot of examples)
- JLink by Segger - interface software for the JLink familiy of programmers
- nrfjprog by Nordic Semiconductor - Wrapper utility around JLink
- arm-non-eabi-gcc by ARM and the GCC Team - compiler toolchain for embedded (= bare metal) ARM chips

## How-to
### Create a project structure

1. Clone this repo (or add as submodule) on the root directory of your project.

1. On the `cmake-nRF5x/examples` select `ble_blinky` if your project uses softdevice or `blinky` for a simple app only. 

1. Make a copy **the contents** on your project root. The final result should look like the tree bellow.

    ```
    .
    ..
    cmake-nRF5x
    src
    build.sh
    CMakeLists.txt
    flash.sh
    nrf-toolchain.cmake
    README.md
    ```

1. In `arm-gcc-toolchain.cmake` change paths to point to the toolchain installed from _Dependencies_.

1. Now you can compile the example by running `./build.sh` and flash it into the device with `./flash.sh`.

1. Observe that LED1 is either blinking or fully lit, depending on the selected example. If the code compiled and flashing worked it is off it means that the selected board does not match the board you flashed into. 

### Migrate another example from the SDK

1. Find an [example](https://infocenter.nordicsemi.com/topic/com.nordic.infocenter.sdk5.v15.3.0/examples.html?cp=5_5_0_4) from the SDK, then copy the contents of it from the SDK folder to your project inside `src`.

1. Copy for a `sdk_config.h`, `main.c` and a linker script (normally named `<project_name>_gcc_<chip familly>.ld`) that fits your chip and project needs.

1. Copy the linker script into the root of your project. Rename it to just `gcc_<chip familly>.ld` For example:
	
	```
	gcc_nrf51.ld
	gcc_nrf52.ld
	```

1. Change `PROJECT_PATH`, `NRF_CONFIG`, and `NRF5_LINKER_SCRIPT` to point to the `src` folder. Adjust as needed for your project.

	_Note_: you can add `CXX` between `C ASM` to add c++ support
	
1. Add additional libraries to `src/CMakeLists.txt`based on the target original `Makefile` found in the SDK example folder inside the board model accordingly to the table bellow.
    ```
    # nrf51 
    pca10028 (nrf51422)
    # nrf52 
    pca10040 (nrf52832)
    pca10056 (nrf52840)
    pca10040e (nrf52810)
    pca10056e (nrf52811)
    pca10059 (nrf52840)
    ```

	We wrapped the most common drivers and libraries with cmake macros. _I.e._ To include BLE services, use `nRF5x_addBLEService(<service name>)`.

	For other SDK libraries you can use the following structure or create your own macros.

	```cmake
	include_directories(
	        "${NRF5_SDK_PATH}/<library header directory path>"
	)
		
	list(APPEND SDK_SOURCE_FILES
	        "${NRF5_SDK_PATH}/<library source file path>"
	)
	```
	
## Command Line
### Build script teardown

After setup you can use cmake as usual:

1. Generate the actual build files (out-of-source builds are strongly recomended):

	```commandline
	cmake -H. -B"cmake-build" -G "Unix Makefiles"
	```
	You can optionally pass the toolchain to `cmake` when configuring:
    ```
    -DCMAKE_TOOLCHAIN_PATH=cmake-nRF5x/arm-gcc-toolchain.cmake
    ```
    but if you do so you must ensure the toolchain binaries are available in your environment PATH (i.e. work on the command line without specifying absolute path)

2. Build your app:

	```commandline
	cmake --build "cmake-build" --target <your project name>
	```

### Flash script teardown

In addition to the build target (named like your project) the script adds some support targets:

`FLASH_SOFTDEVICE` To flash a nRF softdevice to the SoC (typically done only once for each SoC)

```commandline
cmake --build "cmake-build" --target FLASH_SOFTDEVICE
```

`FLASH_<your project name>` To flash your application (this will also rebuild your App first)

```commandline
cmake --build "cmake-build" --target FLASH_<your project name>
```

`FLASH_ERASE` To completely erase the SoC flash

```commandline
cmake --build "cmake-build" --target FLASH_ERASE
```

### JLink Applications

To start the gdb server and RTT terminal, build the target `START_JLINK`:

```commandline
cmake --build "cmake-build" --target START_JLINK
```

## License

MIT for the `CMake_nRF5x.cmake` file. 

Please note that the nRF5x SDK by Nordic Semiconductor is covered by it's own license and shouldn't be re-distributed. 
