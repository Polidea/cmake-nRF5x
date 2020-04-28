# MIT License

# Copyright (c) 2020 Polidea

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
include("nrf5_validate")

# Check nRF SDK
set(NRF5_SDK_PATH "" CACHE PATH "Path to the nRF5 SDK")
set(NRF5_SDK_VERSION "" CACHE STRING "nRF5 SDK version, e.g.: 15.3.0")

nrf5_validate_sdk(${NRF5_SDK_PATH} local_sdk_version)
if(NOT NRF5_SDK_VERSION)
  message(STATUS "nRF SDK version not explicitly provided, using deduced one: ${local_sdk_version}")
  set(NRF5_SDK_VERSION ${local_sdk_version})
else()
  message(STATUS "nRF SDK version ${local_sdk_version} overwritten by ${NRF5_SDK_VERSION}")
endif()
nrf5_validate_sdk_version(${NRF5_SDK_VERSION})

# Check supported board type (based on SDK version as well)
set(NRF5_BOARD "" CACHE STRING "nRF5 DK board e.g. pca10040, pca10056, pca10059")
set(NRF5_TARGET "" CACHE STRING "nRF5 target name e.g. nrf52810, nrf52832, nrf52840")

if(NRF5_BOARD)
  string(TOLOWER ${NRF5_BOARD} NRF5_BOARD)
  nrf5_validate_board(${NRF5_SDK_VERSION} ${NRF5_BOARD} local_board_target local_board_define)
  set(NRF5_BOARD_DEFINE ${local_board_define})
  if(NOT NRF5_TARGET)
    set(NRF5_TARGET ${local_board_target})
    message(STATUS "nRF5 target for board ${NRF5_BOARD} not specified, using: ${NRF5_TARGET}")
  else()
    string(TOLOWER ${NRF5_TARGET} NRF5_TARGET)
    string(COMPARE NOTEQUAL ${NRF5_TARGET} ${local_board_target} board_target_overwritten)
    if(board_target_overwritten)
      message(WARNING "Default nRF5 target for board ${NRF5_BOARD} (${local_board_target}) overwritten by ${NRF5_TARGET}")
    endif()
  endif()
  message(STATUS "Using nRF5 DK board: ${NRF5_BOARD}")
endif()

# Check supported target based on the provided SDK version.
if(NRF5_TARGET)
  nrf5_validate_target(${NRF5_SDK_VERSION} ${NRF5_TARGET} local_target local_target_flags)
  set(NRF5_TARGET ${local_target})
  add_compile_options(${local_target_flags})
  add_link_options(${local_target_flags})
else()
  message(FATAL_ERROR "NRF5_TARGET not specified")
endif()

message(STATUS "Using nRF5 target: ${NRF5_TARGET}")

# Check SoftDevice variant.
set(NRF5_SOFTDEVICE_VARIANT "" CACHE STRING "SoftDevice variant. Set to 'blank' if SoftDevice is not used, otherwise specify version, e.g.: 's130'")

if(NRF5_SOFTDEVICE_VARIANT)
  string(TOLOWER ${NRF5_SOFTDEVICE_VARIANT} NRF5_SOFTDEVICE_VARIANT)
  nrf5_validate_softdevice_variant(${NRF5_SDK_PATH} ${NRF5_SDK_VERSION} ${NRF5_TARGET} ${NRF5_SOFTDEVICE_VARIANT} local_sd_hex_file_path local_sd_flags)
else()
  message(FATAL_ERROR "You must specify NRF5_SOFTDEVICE_VARIANT, e.g: blank, s130")
endif()

message(STATUS "Using SoftDevice HEX file: ${local_sd_hex_file_path}")
message(STATUS "Using SoftDevice variant: ${NRF5_SOFTDEVICE_VARIANT}")

string(TOLOWER ${NRF5_SOFTDEVICE_VARIANT} NRF5_SOFTDEVICE_VARIANT_LOWER)
string(TOUPPER ${NRF5_SOFTDEVICE_VARIANT} NRF5_SOFTDEVICE_VARIANT_UPPER)

# Get linker script.
set(NRF5_LINKER_SCRIPT "" CACHE FILEPATH "Linker script file. If not specified, a generic script for a selected target will be used.")
if(NRF5_LINKER_SCRIPT)
  if(NOT EXISTS ${NRF5_LINKER_SCRIPT})
    message(FATAL_ERROR "Linker script file (NRF5_LINKER_SCRIPT) doesn't exist: ${NRF5_LINKER_SCRIPT}")
  endif()
else()
  nrf5_find_linker_file(${NRF5_SDK_PATH} ${NRF5_SDK_VERSION} ${NRF5_TARGET} ${NRF5_SOFTDEVICE_VARIANT} local_linker_script)
  if (NOT local_linker_script)
    message(FATAL_ERROR "Cannot find generic linker script, please specify it via NRF5_LINKER_SCRIPT variable")
  endif()
  set(NRF5_LINKER_SCRIPT "${local_linker_script}")
endif()

message(STATUS "Using linker script: ${NRF5_LINKER_SCRIPT}")

set(NRF5_SDKCONFIG_PATH "" CACHE PATH "Path to the sdk_config.h file. If not specified, a generic sdk_config.h for a selected target file will be used.")
if(NOT NRF5_SDKCONFIG_PATH)
  set(NRF5_SDKCONFIG_PATH "${NRF5_SDK_PATH}/config/${NRF5_TARGET}/config" CACHE PATH "" FORCE)
endif()

set(NRF5_APPCONFIG_PATH "" CACHE PATH "Path to the app_config.h file. If not specified, app_config.h will not be used.")

message(STATUS "Using sdk_config.h include path: ${NRF5_SDKCONFIG_PATH}")

if(NRF5_APPCONFIG_PATH)
  message(STATUS "Using app_config.h include path: ${NRF5_APPCONFIG_PATH}")
endif()

set(NRF5_NRFJPROG "" CACHE FILEPATH "nrfjprog utility executable file. If not specified, it is assumed that nrfjprog is available from PATH.")
if(NOT NRF5_NRFJPROG)
  set(NRF5_NRFJPROG "nrfjprog" CACHE FILEPATH "" FORCE)
  message(STATUS "Using nrfjprog utility available from PATH")
else()
  message(STATUS "Using nrfjprog utility: ${NRF5_NRFJPROG}")
endif()

add_library(nrf5_config INTERFACE)
target_include_directories(nrf5_config INTERFACE "${NRF5_SDKCONFIG_PATH}")
if(NRF5_APPCONFIG_PATH)
  target_include_directories(nrf5_config INTERFACE "${NRF5_APPCONFIG_PATH}")
  target_compile_definitions(nrf5_config INTERFACE USE_APP_CONFIG)
endif()

# Microcontroller Development Kit (MDK)
nrf5_get_startup_file(${NRF5_SDK_PATH} ${NRF5_TARGET} out_startup_file out_system_file)

add_library(nrf5_mdk OBJECT EXCLUDE_FROM_ALL
  "${out_startup_file}"
  "${out_system_file}"
)
target_include_directories(nrf5_mdk PUBLIC
  "${NRF5_SDK_PATH}/components/toolchain/cmsis/include"
  "${NRF5_SDK_PATH}/modules/nrfx/mdk"
)

# SoC header files (SoftDevice variant)
# NOTE: there is another variant of this dependency for non-SoftDevice projects but it is not supported by this solution
add_library(nrf5_soc INTERFACE)
target_include_directories(nrf5_soc INTERFACE
  "${NRF5_SDK_PATH}/components/softdevice/${NRF5_SOFTDEVICE_VARIANT_LOWER}/headers"
  "${NRF5_SDK_PATH}/components/softdevice/${NRF5_SOFTDEVICE_VARIANT_LOWER}/headers/nrf52"
)
target_compile_definitions(nrf5_soc INTERFACE
  SOFTDEVICE_PRESENT  
  ${NRF5_SOFTDEVICE_VARIANT_UPPER}
)

include("nrf5_common")
include("nrf5_storage")
include("nrf5_log")
include("nrf5_app")
include("nrf5_nrfx")
include("nrf5_bsp")
include("nrf5_crypto")
include("nrf5_ble")
include("nrf5_ble_pm")
include("nrf5_ble_srv")

# Memory Manager
add_library(nrf5_mem_manager OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/mem_manager/mem_manager.c"
)
target_include_directories(nrf5_mem_manager PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/mem_manager"
)
target_link_libraries(nrf5_mem_manager PUBLIC nrf5_log)

# Logger Serial backend
add_library(nrf5_log_backend_serial OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/log/src/nrf_log_backend_serial.c"
)
target_link_libraries(nrf5_log_backend_serial PUBLIC nrf5_log)

# Logger UART backend
add_library(nrf5_log_backend_uart OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/log/src/nrf_log_backend_uart.c"
)
target_link_libraries(nrf5_log_backend_uart PUBLIC nrf5_log nrf5_drv_uart)

# Segger RTT
add_library(nrf5_ext_segger_rtt OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/external/segger_rtt/SEGGER_RTT.c"
)
target_include_directories(nrf5_ext_segger_rtt PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/external/segger_rtt"
)
target_link_libraries(nrf5_ext_segger_rtt PUBLIC nrf5_config nrf5_mdk nrf5_soc)

# Logger RTT backend
add_library(nrf5_log_backend_rtt OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/log/src/nrf_log_backend_rtt.c"
)
target_link_libraries(nrf5_log_backend_rtt PUBLIC nrf5_log nrf5_ext_segger_rtt)

# Logger (default backends)
add_library(nrf5_log_default_backends OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/log/src/nrf_log_default_backends.c"
)
target_link_libraries(nrf5_log_default_backends PUBLIC nrf5_log)

# Sensor Data Simulator
add_library(nrf5_sensorsim OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/sensorsim/sensorsim.c"
)
target_include_directories(nrf5_sensorsim PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/sensorsim"
)

# IoT Common
add_library(nrf5_iot_common INTERFACE)
target_include_directories(nrf5_iot_common INTERFACE
  "${NRF5_SDK_PATH}/components/iot/common"
)

function(nrf5_target exec_target)
  # nrf5_mdk must be linked as startup_*.S contains definition of the Reset_Handler entry symbol 
  target_link_libraries(${exec_target} PRIVATE nrf5_mdk)
  target_link_options(${exec_target} PRIVATE
    "-L${NRF5_SDK_PATH}/modules/nrfx/mdk"
    "-T${NRF5_LINKER_SCRIPT}"
  )
  # print size information after build
  add_custom_command(TARGET ${exec_target} POST_BUILD
    COMMAND ${CMAKE_SIZE_BIN} "${exec_target}"
  )
  # targets for creating Intel HEX and binary executable forms
  add_custom_target(hex DEPENDS ${exec_target} COMMAND ${CMAKE_OBJCOPY_BIN} -O ihex "${exec_target}" "${exec_target}.hex")
  add_custom_target(bin DEPENDS ${exec_target} COMMAND ${CMAKE_OBJCOPY_BIN} -O binary "${exec_target}" "${exec_target}.bin")
  # target for flashing SoftDevice
  add_custom_target(flash_softdevice
    COMMAND ${NRF5_NRFJPROG} --program ${local_sd_hex_file_path} -f nrf52 --sectorerase
    COMMAND ${NRF5_NRFJPROG} --reset -f nrf52
  )
  # target for flashing the output executable
  add_custom_target(flash DEPENDS hex 
    COMMAND ${NRF5_NRFJPROG} --program "${exec_target}.hex" -f nrf52 --sectorerase
    COMMAND ${NRF5_NRFJPROG} --reset -f nrf52
  )
  # target for erasing Flash memory and the UICR page
  add_custom_target(erase_all
    COMMAND ${NRF5_NRFJPROG} --eraseall -f nrf52
  )
endfunction()
