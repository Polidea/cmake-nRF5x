# MIT License

# Copyright (c) 2019 Polidea

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

include("nrf5_utils")

set(NRF5_SDK_PATH "" CACHE PATH "Path to the nRF5 SDK")
if(NOT NRF5_SDK_PATH)
  message(FATAL_ERROR "NRF5_SDK_PATH not specified")
endif()

set(NRF5_TARGET "" CACHE STRING "nRF5 target name e.g. nrf52810, nrf52832, nrf52840")
if(NRF5_TARGET)
  nrf5_validate_target(${NRF5_TARGET})
else()
  message(FATAL_ERROR "NRF5_TARGET not specified")
endif()

set(NRF5_LINKER_SCRIPT "" CACHE FILEPATH "Linker script file. If not specified, a generic script for a selected target will be used.")
if(NRF5_LINKER_SCRIPT)
  if(NOT EXISTS ${NRF5_LINKER_SCRIPT})
    message(FATAL_ERROR "Linker script file (NRF5_LINKER_SCRIPT) doesn't exist: ${NRF5_LINKER_SCRIPT}")
  endif()
else()
  set(NRF5_LINKER_SCRIPT "${NRF5_SDK_PATH}/config/${NRF5_TARGET}/armgcc/generic_gcc_nrf52.ld" CACHE FILEPATH "" FORCE)
endif()

message(STATUS "Using linker script: ${NRF5_LINKER_SCRIPT}")

set(NRF5_SDKCONFIG_PATH "" CACHE PATH "Path to the sdk_config.h file. If not specified, a generic sdk_config.h for a selected target file will be used.")
if(NOT NRF5_SDKCONFIG_PATH)
  set(NRF5_SDKCONFIG_PATH "${NRF5_SDK_PATH}/config/${NRF5_TARGET}/config" CACHE PATH "" FORCE)
endif()

message(STATUS "Using sdk_config.h include path: ${NRF5_SDKCONFIG_PATH}")

nrf5_get_device_name(NRF5_DEVICE_NAME ${NRF5_TARGET})
nrf5_get_mdk_postfix(NRF5_MDK_POSTFIX ${NRF5_TARGET})
nrf5_get_softdevice_variant(NRF5_SOFTDEVICE_VARIANT ${NRF5_TARGET})

add_library(nrf5_mdk OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/mdk/gcc_startup_${NRF5_MDK_POSTFIX}.S"
  "${NRF5_SDK_PATH}/modules/nrfx/mdk/system_${NRF5_MDK_POSTFIX}.c"
)
target_include_directories(nrf5_mdk PUBLIC
  "${NRF5_SDK_PATH}/components/toolchain/cmsis/include"
  "${NRF5_SDK_PATH}/modules/nrfx/mdk"
)
target_compile_definitions(nrf5_mdk PUBLIC
  ${NRF5_DEVICE_NAME}
)

add_library(nrf5_common OBJECT EXCLUDE_FROM_ALL
  # App Error
  "${NRF5_SDK_PATH}/components/libraries/util/app_error_weak.c"
  "${NRF5_SDK_PATH}/components/libraries/util/app_error.c"
  # Logger
  "${NRF5_SDK_PATH}/components/libraries/log/src/nrf_log_frontend.c"
  "${NRF5_SDK_PATH}/components/libraries/log/src/nrf_log_str_formatter.c"
  # Section variables
  "${NRF5_SDK_PATH}/components/libraries/experimental_section_vars/nrf_section_iter.c"
  # strerror
  "${NRF5_SDK_PATH}/components/libraries/strerror/nrf_strerror.c"
)
target_include_directories(nrf5_common PUBLIC
  # SDK Config (sdk_config.h)
  "${NRF5_SDKCONFIG_PATH}"
  # SoftDevice
  "${NRF5_SDK_PATH}/components/softdevice/${NRF5_SOFTDEVICE_VARIANT}/headers"
  "${NRF5_SDK_PATH}/components/softdevice/${NRF5_SOFTDEVICE_VARIANT}/headers/nrf52"
  # Utilities
  "${NRF5_SDK_PATH}/components/libraries/util"
  # Logger
  "${NRF5_SDK_PATH}/components/libraries/log"
  "${NRF5_SDK_PATH}/components/libraries/log/src"
  # Section variables
  "${NRF5_SDK_PATH}/components/libraries/experimental_section_vars"
  # strerror (string to error conversion)
  "${NRF5_SDK_PATH}/components/libraries/strerror"
)
target_link_libraries(nrf5_common PUBLIC nrf5_mdk)
