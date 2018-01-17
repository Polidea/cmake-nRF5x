# cmake-nRF5x

Cmake script for projects targeting Nordic Semiconductor nRF5x series devices using the GCC toolchain from ARM.

# Dependencies

The script makes use of the following tools:

- nRF5x SDK by Nordic Semiconductor - SoC specific drivers and libraries (also includes a lot of examples)
- JLink by Segger - interface software for the JLink familiy of programmers
- nrfjprog by Nordic Semiconductor - Wrapper utility around JLink
- arm-non-eabi-gcc by ARM and the GCC Team - compiler toolchain for embedded (= bare metal) ARM chips

# Setup

1. Place the CMake_nRF5x.cmake into the root of your project

2. Search the SDK `example` directory for a `sdk_config.h` and a linker script (normally named `<project_name>_gcc_<chip familly>.ld`) that fits your chip and project needs.

3. Copy the `sdk_config.h` into the root of your project. Modify it as required for you project.

4. Copy the linker script into the root of your project. Rename it to just `gcc_<chip familly>.ld` For example:
	
	```
	gcc_nrf51.ld
	gcc_nrf52.ld
	```
5. Create a new `CMakeLists.txt` file at the same level. Add the project standard cmake project header

	```cmake
	cmake_minimum_required(VERSION 3.6)
	project(your_project_name C ASM)
	```
Note: you can add `CXX` between `C ASM` to add c++ support
	
6. Set your target chip family: `nRF51` or `nRF52`

	```cmake
	set(NRF_TARGET "nrf51") 
	```

7. Set variables with paths to external dependencies:

	```cmake
	set(ARM_NONE_EABI_TOOLCHAIN_PATH "/Users/example/toolchains/gcc-arm-none-eabi-6_2")
	set(NRF5_SDK_PATH "/Users/example/toolchains/nRF5/nRF5_SDK_12.2.0")
	set(NRFJPROG "/Users/example/toolchains/nRF5/nrfjprog/nrfjprog")
	```
	
	Optional: You can put the above lines into a separate file (e.g. `CmakeEnv.cmake`) and include it in the `CMakeLists.txt` file:

	```cmake 
	include("CMakeEnv.cmake")
	```

8. Include this script so the "CMakeLists.txt" can use it

	```cmake
	include("CMake_nRF5x.cmake")
	```

9. Perform the base setup

	```cmake
	nRF5x_setup()
	```
	
10. Optionally add additional libraries:

	```cmake
	nRF5x_addAppFIFO()
	```
	Note: only the most common drivers and libraries are wrapped with cmake macros. If you need more, you can use `include_directories` and `list(APPEND SDK_SOURCE_FILES ...)` to add them. For example, in order to add the Bluetooth Battery Service:

	```cmake
	include_directories(
	        "${NRF5_SDK_PATH}/components/ble/ble_services/ble_bas"
	)
		
	list(APPEND SDK_SOURCE_FILES
	        "${NRF5_SDK_PATH}/components/ble/ble_services/ble_bas/ble_bas.c"
	        )
	```
	
11. Append you source files using `list(APPEND SOURCE_FILES ...)` and headers using `include_directories`. For example:

	```cmake
	include_directories(".")
	list(APPEND SOURCE_FILES "main.c")
	```

12. Finish setup by calling `nRF5x_addExecutable`

	```cmake
	nRF5x_addExecutable(${PROJECT_NAME} "${SOURCE_FILES}")
	```

# Build

After setup you can use cmake as usual:

1. Generate the actual build files (out-of-source builds are strongly recomended):

	```commandline
	cmake -H. -B"cmake-build" -G "Unix Makefiles"
	```

2. Build your app:

	```commandline
	cmake --build "cmake-build" --target <your project name>
	```

# Flash

In addition to the build target (named like your project) the script adds some support targets:

`FLASH_SOFTDEVICE` To flash a nRF softdevice to the SoC (typically done only once for each SoC)

```commandline
cmake --build "cmake-build" --target FLASH_SOFTDEVICE
```

`FLASH_<your project name>` To flash your application (typically done after you change and build your app)

```commandline
cmake --build "cmake-build" --target FLASH_<your project name>
```

`FLASH_ERASE` To completely erase the SoC flash

```commandline
cmake --build "cmake-build" --target FLASH_ERASE
```

# License

MIT for the `CMake_nRF5x.cmake` file. 

Please note that the nRF5x SDK by Nordic Semiconductor is covered by it's own license and shouldn't be re-distributed. 
