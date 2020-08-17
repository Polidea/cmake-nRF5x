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
include("nrf5_helpers")

# Check nRF SDK
set(NRF5_SDK_PATH "" CACHE PATH "Path to the nRF5 SDK")
set(NRF5_SDK_VERSION "" CACHE STRING "nRF5 SDK version, e.g.: 15.3.0")

if(NOT NRF5_SDK_PATH)
  message(FATAL_ERROR "Path to the nRF5 SDK not provided. Please set NRF5_SDK_PATH cache variable.")
endif()

nrf5_get_sdk_version(${NRF5_SDK_PATH} local_sdk_version)
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
  nrf5_get_board_target(${NRF5_SDK_VERSION} ${NRF5_BOARD} local_board_target local_board_define)
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
  nrf5_get_target_flags(${NRF5_SDK_VERSION} ${NRF5_TARGET} local_target local_target_short local_target_flags)
  set(NRF5_TARGET ${local_target})
  add_compile_options(${local_target_flags})
  add_link_options(${local_target_flags})
  if(NRF5_BOARD_DEFINE)
    add_compile_options("-D${NRF5_BOARD_DEFINE}")
  endif()
  nrf5_split_target(${NRF5_TARGET} NRF5_TARGET_FAMILY NRF5_TARGET_VARIANT NRF5_TARGET_GROUP)
else()
  message(FATAL_ERROR "NRF5_TARGET not specified")
endif()

message(STATUS "Using nRF5 target: ${NRF5_TARGET}")

# Check SoftDevice variant.
set(NRF5_SOFTDEVICE_VARIANT "" CACHE STRING "SoftDevice variant. Set to 'blank' if SoftDevice is not used, otherwise specify version, e.g.: 's130'")

if(NRF5_SOFTDEVICE_VARIANT)
  string(TOLOWER ${NRF5_SOFTDEVICE_VARIANT} NRF5_SOFTDEVICE_VARIANT)
  if(NRF5_SOFTDEVICE_VARIANT STREQUAL "mbr")
    nrf5_get_mbr_data(${NRF5_SDK_PATH} ${NRF5_SDK_VERSION} ${local_target_short} local_mbr_hex_file_path local_mbr_flags)
    add_compile_options(${local_mbr_flags})
    add_link_options(${local_mbr_flags})
  elseif(NOT NRF5_SOFTDEVICE_VARIANT STREQUAL "blank")
    nrf5_get_softdevice_data(${NRF5_SDK_PATH} ${NRF5_SDK_VERSION} ${NRF5_TARGET} ${NRF5_SOFTDEVICE_VARIANT} local_sd_hex_file_path local_sd_flags)
    add_compile_options(${local_sd_flags})
    add_link_options(${local_sd_flags})
  endif()
else()
  message(FATAL_ERROR "You must specify NRF5_SOFTDEVICE_VARIANT, e.g: blank, s130")
endif()

message(STATUS "Using SoftDevice variant: ${NRF5_SOFTDEVICE_VARIANT}")

if(local_mbr_hex_file_path)
  message(STATUS "Using MBR HEX file: ${local_mbr_hex_file_path}")
endif()

if(local_sd_hex_file_path)
  message(STATUS "Using SoftDevice HEX file: ${local_sd_hex_file_path}")
endif()

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
  message(WARNING "NRF5_LINKER_SCRIPT not specified, using a generic linker script: ${NRF5_LINKER_SCRIPT}.\n"
    "This is NOT recommended since such scripts may contain invalid memory regions or have some sections missing which "
    "will result in builing an incorrect binary. Please write a custom linker script or copy the generic script "
    "from the SDK and modify it as needed.")
endif()

message(STATUS "Using linker script: ${NRF5_LINKER_SCRIPT}")

# SDK config file
set(NRF5_SDKCONFIG_PATH "" CACHE PATH "Path to the sdk_config.h file. If not specified, a generic sdk_config.h for a selected target file will be used.")
if(NOT NRF5_SDKCONFIG_PATH)
  nrf5_find_sdk_config_file(${NRF5_SDK_PATH} ${NRF5_SDK_VERSION} ${NRF5_TARGET} out_sdk_config_path)
  if(NOT out_sdk_config_path)
    message(FATAL_ERROR "Cannot find generic SDK config file, please specify it via NRF5_SDKCONFIG_PATH variable")
  endif()
  set(NRF5_SDKCONFIG_PATH "${out_sdk_config_path}")
else()
  if (NOT EXISTS "${NRF5_SDKCONFIG_PATH}/sdk_config.h")
    message(FATAL_ERROR "SDK config file not found in ${NRF5_SDKCONFIG_PATH}")
  endif()
endif()

message(STATUS "Using sdk_config.h include path: ${NRF5_SDKCONFIG_PATH}")

# App config path
set(NRF5_APPCONFIG_PATH "" CACHE PATH "Path to the app_config.h file. If not specified, app_config.h will not be used.")

if(NRF5_APPCONFIG_PATH)
  message(STATUS "Using app_config.h include path: ${NRF5_APPCONFIG_PATH}")
endif()

# NOTE: if `__STACK_SIZE` and/or `__HEAP_SIZE` are not the defined, the startup (.S) file automatically defines stack/heap boundaries
# using default values for the specified target

# Stack size
set(NRF5_STACK_SIZE "" CACHE STRING "Max. size of the stack (in bytes), defines `__STACK_SIZE` accordingly. If not specified, a default value for the specified target will be used.")
if(NRF5_STACK_SIZE)
  if(NOT NRF5_STACK_SIZE MATCHES "^[1-9][0-9]*$")
    message(FATAL_ERROR "NRF5_STACK_SIZE must be a positive decimal integer")
  endif()
  add_compile_options("-D__STACK_SIZE=${NRF5_STACK_SIZE}")
  message(STATUS "Using stack size: ${NRF5_STACK_SIZE}")
endif()

# Heap size
set(NRF5_HEAP_SIZE "" CACHE STRING "Max. size of the heap (in bytes), defines `__HEAP_SIZE` accordingly. If not specified, a default value for the specified target will be used.")
if(NRF5_HEAP_SIZE)
  if(NOT NRF5_HEAP_SIZE MATCHES "^[1-9][0-9]*$")
    message(FATAL_ERROR "NRF5_HEAP_SIZE must be a positive decimal integer")
  endif()
  add_compile_options("-D__HEAP_SIZE=${NRF5_HEAP_SIZE}")
  message(STATUS "Using heap size: ${NRF5_HEAP_SIZE}")
endif()

# NRFJPROG executable
set(NRF5_NRFJPROG "" CACHE FILEPATH "nrfjprog utility executable file. If not specified, it is assumed that nrfjprog is available from PATH.")
if(NOT NRF5_NRFJPROG)
  set(NRF5_NRFJPROG "nrfjprog" CACHE FILEPATH "" FORCE)
  message(STATUS "Using nrfjprog utility available from PATH")
else()
  message(STATUS "Using nrfjprog utility: ${NRF5_NRFJPROG}")
endif()

# Serial number of SEGGER J-LINK used by NRFJPROG
set(NRF5_JLINK_SN "" CACHE STRING "Serial number of the SEGGER J-LINK debugger to use when executing nrfjprog commands. If not specified, user will be prompted which connected J-Link to use for each command.")
if(NRF5_JLINK_SN)
  if(NOT NRF5_JLINK_SN MATCHES "^[0-9]*$")
    message(FATAL_ERROR "NRF5_JLINK_SN must contain numbers only")
  endif()
  message(STATUS "Using SEGGER J-Link serial number: ${NRF5_JLINK_SN}")
  set(nrfjprog_jlink_sn_opt "--snr")
  set(nrfjprog_jlink_sn_arg "${NRF5_JLINK_SN}")
endif()

# Config library
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

if(${NRF5_SOFTDEVICE_VARIANT} MATCHES "^(blank|mbr)$")
  # SoC no SoftDevice variant.
  add_library(nrf5_soc OBJECT EXCLUDE_FROM_ALL
    "${NRF5_SDK_PATH}/components/drivers_nrf/nrf_soc_nosd/nrf_nvic.c"
    "${NRF5_SDK_PATH}/components/drivers_nrf/nrf_soc_nosd/nrf_soc.c"
  )
  target_include_directories(nrf5_soc INTERFACE
    "${NRF5_SDK_PATH}/components/drivers_nrf/nrf_soc_nosd"
  )
  target_link_libraries(nrf5_soc PUBLIC nrf5_mdk)
  # Additional include dirs. for the 'mbr' variant
  if(${NRF5_SOFTDEVICE_VARIANT} STREQUAL "mbr")
    if(NRF5_SDK_VERSION VERSION_GREATER_EQUAL 16.0.0)
      target_include_directories(nrf5_soc INTERFACE "${NRF5_SDK_PATH}/components/softdevice/mbr/headers")
    else()
      target_include_directories(nrf5_soc INTERFACE "${NRF5_SDK_PATH}/components/softdevice/mbr/${local_target_short}/headers")
    endif()
  endif()
else()
  # SoC SoftDevice variant.
  add_library(nrf5_soc INTERFACE)
  target_include_directories(nrf5_soc INTERFACE
    "${NRF5_SDK_PATH}/components/softdevice/${NRF5_SOFTDEVICE_VARIANT}/headers"
    "${NRF5_SDK_PATH}/components/softdevice/${NRF5_SOFTDEVICE_VARIANT}/headers/nrf52"
  )
  target_link_libraries(nrf5_soc INTERFACE nrf5_mdk)
endif()

# nRF hardfault handler
add_library(nrf5_hardfault_handler OBJECT EXCLUDE_FROM_ALL)
target_include_directories(nrf5_hardfault_handler PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_sources(nrf5_hardfault_handler PRIVATE
  "${NRF5_SDK_PATH}/components/libraries/hardfault/${NRF5_TARGET_FAMILY}/handler/hardfault_handler_gcc.c"
)
target_link_libraries(nrf5_hardfault_handler PUBLIC
  "nrf5_config"
  "nrf5_mdk"
  "nrf5_soc"
)

# Target definitions
include("nrf5_common")
include("nrf5_storage")
include("nrf5_log")
include("nrf5_app")
include("nrf5_nrfx")
include("nrf5_drv")
include("nrf5_bsp")
include("nrf5_crypto")
include("nrf5_ble")
include("nrf5_ble_pm")
include("nrf5_ble_srv")
include("nrf5_iot")
include("nrf5_usbd")
include("nrf5_dfu")
include("nrf5_misc")
include("nrf5_external")
include("nrf5_external_libs")
include("nrf5_groups")

function(nrf5_target exec_target)
  # nrf5_mdk must be linked as startup_*.S contains definition of the Reset_Handler entry symbol 
  target_link_libraries(${exec_target} PRIVATE nrf5_mdk)
  target_link_options(${exec_target} PRIVATE
    "-L${NRF5_SDK_PATH}/modules/nrfx/mdk"
    "-T${NRF5_LINKER_SCRIPT}"
  )
  # Print size information after build
  add_custom_command(TARGET ${exec_target} POST_BUILD
    COMMAND ${CMAKE_SIZE_BIN} "${exec_target}"
  )
  # Targets for creating Intel HEX and binary executable forms
  add_custom_target(hex DEPENDS ${exec_target} COMMAND ${CMAKE_OBJCOPY_BIN} -O ihex "${exec_target}" "${exec_target}.hex")
  add_custom_target(bin DEPENDS ${exec_target} COMMAND ${CMAKE_OBJCOPY_BIN} -O binary "${exec_target}" "${exec_target}.bin")
  # Target for flashing SoftDevice
  if(local_sd_hex_file_path)
    add_custom_target(flash_softdevice
      COMMAND ${NRF5_NRFJPROG} --program ${local_sd_hex_file_path} -f nrf52 --sectorerase ${nrfjprog_jlink_sn_opt} ${nrfjprog_jlink_sn_arg}
      COMMAND ${NRF5_NRFJPROG} --reset -f nrf52 ${nrfjprog_jlink_sn_opt} ${nrfjprog_jlink_sn_arg}
    )
  else()
    add_custom_target(flash_softdevice COMMAND true COMMENT "Using a non-SoftDevice configuration (${NRF5_SOFTDEVICE_VARIANT}). Nothing to flash.")
  endif()
  # Target for flashing MBR
  if(local_mbr_hex_file_path)
    add_custom_target(flash_mbr
      COMMAND ${NRF5_NRFJPROG} --program ${local_mbr_hex_file_path} -f nrf52 --sectorerase ${nrfjprog_jlink_sn_opt} ${nrfjprog_jlink_sn_arg}
      COMMAND ${NRF5_NRFJPROG} --reset -f nrf52 ${nrfjprog_jlink_sn_opt} ${nrfjprog_jlink_sn_arg}
    )
  else()
    if(local_sd_hex_file_path)
      add_custom_target(flash_mbr COMMAND true COMMENT "Using a SoftDevice configuration (${NRF5_SOFTDEVICE_VARIANT}). Build \'flash_softdevice\' target to flash both MBR and SoftDevice.")
    else()
      add_custom_target(flash_mbr COMMAND true COMMENT "Using a non-SoftDevice configuration (${NRF5_SOFTDEVICE_VARIANT}). Nothing to flash.")
    endif()
  endif()
  # Target for flashing the output executable
  add_custom_target(flash DEPENDS hex 
    COMMAND ${NRF5_NRFJPROG} --program "${exec_target}.hex" -f nrf52 --sectorerase ${nrfjprog_jlink_sn_opt} ${nrfjprog_jlink_sn_arg}
    COMMAND ${NRF5_NRFJPROG} --reset -f nrf52 ${nrfjprog_jlink_sn_opt} ${nrfjprog_jlink_sn_arg}
  )
  # Target for erasing Flash memory and the UICR page
  add_custom_target(erase_all
    COMMAND ${NRF5_NRFJPROG} --eraseall -f nrf52 ${nrfjprog_jlink_sn_opt} ${nrfjprog_jlink_sn_arg}
  )
endfunction()
