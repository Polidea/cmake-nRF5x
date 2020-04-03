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

message(STATUS "Using nRF5 target: ${NRF5_TARGET}")

set(NRF5_BOARD "" CACHE STRING "nRF5 DK board e.g. pca10040, pca10056, pca10059")
if(NRF5_BOARD)
  nrf5_validate_board(${NRF5_BOARD})
  string(TOLOWER ${NRF5_BOARD} NRF5_BOARD_LOWER)
  string(TOUPPER ${NRF5_BOARD} NRF5_BOARD_UPPER)
endif()

message(STATUS "Using nRF5 DK board: ${NRF5_BOARD}")

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

set(NRF5_SOFTDEVICE_VARIANT "" CACHE STRING "SoftDevice variant. If not specified, a variant typical for the specified target will be used.")

set(NRF5_SOFTDEVICE_HEX "" CACHE FILEPATH "SoftDevice HEX file. If not specified, a SoftDevice file typical for specified the target found in the SDK will be used.")
if(NOT NRF5_SOFTDEVICE_HEX)
  nrf5_get_softdevice_variant(softdevice_variant ${NRF5_TARGET})
  nrf5_find_softdevice_file(softdevice_hex "${NRF5_SDK_PATH}/components/softdevice" ${softdevice_variant})
  if(NOT softdevice_hex)
    message(FATAL_ERROR "Unable to find SoftDevice HEX file for the ${softdevice_variant} variant")
  endif()
  set(NRF5_SOFTDEVICE_VARIANT ${softdevice_variant} CACHE STRING "" FORCE)
  set(NRF5_SOFTDEVICE_HEX ${softdevice_hex} CACHE FILEPATH "" FORCE)
else()
  if(NOT NRF5_SOFTDEVICE_VARIANT)
    message(FATAL_ERROR "When using custom SoftDevice HEX file, you must specify the SoftDevice variant (NRF5_SOFTDEVICE_VARIANT) e.g. S112, S132, S140")
  endif()
  nrf5_validate_softdevice_variant(${NRF5_SOFTDEVICE_VARIANT})
endif()

message(STATUS "Using SoftDevice HEX file: ${NRF5_SOFTDEVICE_HEX}")
message(STATUS "Using SoftDevice variant: ${NRF5_SOFTDEVICE_VARIANT}")

string(TOLOWER ${NRF5_SOFTDEVICE_VARIANT} NRF5_SOFTDEVICE_VARIANT_LOWER)
string(TOUPPER ${NRF5_SOFTDEVICE_VARIANT} NRF5_SOFTDEVICE_VARIANT_UPPER)

nrf5_get_device_name(NRF5_DEVICE_NAME ${NRF5_TARGET})
nrf5_get_mdk_postfix(NRF5_MDK_POSTFIX ${NRF5_TARGET})

add_library(nrf5_config INTERFACE)
target_include_directories(nrf5_config INTERFACE "${NRF5_SDKCONFIG_PATH}")
if(NRF5_APPCONFIG_PATH)
  target_include_directories(nrf5_config INTERFACE "${NRF5_APPCONFIG_PATH}")
  target_compile_definitions(nrf5_config INTERFACE USE_APP_CONFIG)
endif()

# Microcontroller Development Kit (MDK)
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

# SoftDevice headers
add_library(nrf5_softdevice_headers INTERFACE)
target_include_directories(nrf5_softdevice_headers INTERFACE
  "${NRF5_SDK_PATH}/components/softdevice/${NRF5_SOFTDEVICE_VARIANT_LOWER}/headers"
  "${NRF5_SDK_PATH}/components/softdevice/${NRF5_SOFTDEVICE_VARIANT_LOWER}/headers/nrf52"
)
target_compile_definitions(nrf5_softdevice_headers INTERFACE
  ${NRF5_SOFTDEVICE_VARIANT_UPPER}
)

# strerror (error to string converion)
add_library(nrf5_strerror OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/strerror/nrf_strerror.c"
)
target_include_directories(nrf5_strerror PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/strerror"
)
target_link_libraries(nrf5_strerror PUBLIC nrf5_config nrf5_mdk nrf5_softdevice_headers)

# Section variables (experimental)
add_library(nrf5_section OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/experimental_section_vars/nrf_section_iter.c"
)
target_include_directories(nrf5_section PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/experimental_section_vars"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_section nrf5_config nrf5_mdk nrf5_softdevice_headers)

# fprintf
add_library(nrf5_fprintf OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/external/fprintf/nrf_fprintf.c"
  "${NRF5_SDK_PATH}/external/fprintf/nrf_fprintf_format.c"
)
target_include_directories(nrf5_fprintf PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/external/fprintf"
)
target_link_libraries(nrf5_fprintf PUBLIC nrf5_mdk nrf5_softdevice_headers nrf5_config)

# Atomic
add_library(nrf5_atomic OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/atomic/nrf_atomic.c"
)
target_include_directories(nrf5_atomic PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/atomic"
)
target_link_libraries(nrf5_atomic PUBLIC nrf5_mdk nrf5_softdevice_headers nrf5_config)

# Mutex
add_library(nrf5_mtx INTERFACE)
target_include_directories(nrf5_mtx INTERFACE
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/mutex"
)
target_link_libraries(nrf5_mtx INTERFACE nrf5_atomic)

# Logger forwarding interface (include directories only)
add_library(nrf5_log_fwd INTERFACE)
target_include_directories(nrf5_log_fwd INTERFACE
  "${NRF5_SDK_PATH}/components/libraries/log"
  "${NRF5_SDK_PATH}/components/libraries/log/src"
)

# SoftDevice handler
add_library(nrf5_sdh OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/softdevice/common/nrf_sdh.c"
)
target_include_directories(nrf5_sdh PUBLIC
"${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/softdevice/common"
)
target_link_libraries(nrf5_sdh PUBLIC nrf5_section nrf5_log_fwd nrf5_strerror)

# Power management
add_library(nrf5_pwr_mgmt OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/pwr_mgmt/nrf_pwr_mgmt.c"
)
target_include_directories(nrf5_pwr_mgmt PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/pwr_mgmt"
)
target_link_libraries(nrf5_pwr_mgmt PUBLIC nrf5_mtx nrf5_section nrf5_nrfx_hal nrf5_log_fwd nrf5_memobj nrf5_sdh)

# Queue
add_library(nrf5_queue OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/queue/nrf_queue.c"
)
target_include_directories(nrf5_queue PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/queue"
)
target_link_libraries(nrf5_queue PUBLIC nrf5_section nrf5_log_fwd nrf5_strerror)

# Command Line Interface (CLI)
add_library(nrf5_cli OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/cli/nrf_cli.c"
)
target_include_directories(nrf5_cli PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/cli"
)
target_link_libraries(nrf5_cli PUBLIC nrf5_atomic nrf5_section nrf5_log_fwd nrf5_memobj nrf5_queue nrf5_fprintf nrf5_delay nrf5_nrfx_common nrf5_pwr_mgmt)

# Block allocator
add_library(nrf5_balloc OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/balloc/nrf_balloc.c"
)
target_include_directories(nrf5_balloc PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/balloc"
)
target_link_libraries(nrf5_balloc PUBLIC nrf5_section nrf5_log_fwd nrf5_softdevice_headers nrf5_strerror)

# Memory object
add_library(nrf5_memobj OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/memobj/nrf_memobj.c"
)
target_include_directories(nrf5_memobj PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/memobj"
)
target_link_libraries(nrf5_memobj PUBLIC nrf5_balloc nrf5_atomic)

# Ring buffer
add_library(nrf5_ringbuf OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/ringbuf/nrf_ringbuf.c"
)
target_include_directories(nrf5_ringbuf PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/ringbuf"
)
target_link_libraries(nrf5_ringbuf PUBLIC nrf5_atomic)

# Atomic FIFO
add_library(nrf5_atfifo OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/atomic_fifo/nrf_atfifo.c"
)
target_include_directories(nrf5_atfifo PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/atomic_fifo"
)
target_link_libraries(nrf5_atfifo PUBLIC nrf5_section nrf5_log_fwd nrf5_strerror)

# File storage
add_library(nrf5_fstorage OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/fstorage/nrf_fstorage.c"
  "${NRF5_SDK_PATH}/components/libraries/fstorage/nrf_fstorage_sd.c"
)
target_include_directories(nrf5_fstorage PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/fstorage"
)
target_link_libraries(nrf5_fstorage PUBLIC nrf5_section nrf5_log_fwd nrf5_strerror nrf5_sdh nrf5_atomic nrf5_atfifo)

# File data storage
add_library(nrf5_fds OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/fds/fds.c"
)
target_include_directories(nrf5_fds PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/fds"
)
target_link_libraries(nrf5_fds PUBLIC nrf5_fstorage)

# Logger (frontend & formatter)
add_library(nrf5_log OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/log/src/nrf_log_frontend.c"
  "${NRF5_SDK_PATH}/components/libraries/log/src/nrf_log_str_formatter.c"
)
target_include_directories(nrf5_log PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/log"
  "${NRF5_SDK_PATH}/components/libraries/log/src"
)
target_link_libraries(nrf5_log PUBLIC nrf5_config nrf5_mdk nrf5_softdevice_headers nrf5_section nrf5_strerror nrf5_memobj nrf5_fprintf nrf5_ringbuf nrf5_cli nrf5_fds)

# Application error
add_library(nrf5_app_error OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/util/app_error_weak.c"
  "${NRF5_SDK_PATH}/components/libraries/util/app_error.c"
)
target_include_directories(nrf5_app_error PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_app_error PUBLIC nrf5_mdk nrf5_softdevice_headers nrf5_log nrf5_section nrf5_strerror nrf5_memobj)

# Scheduler
add_library(nrf5_app_scheduler OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/scheduler/app_scheduler.c"
)
target_include_directories(nrf5_app_scheduler PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/scheduler"
)
target_link_libraries(nrf5_app_scheduler PUBLIC nrf5_config nrf5_mdk nrf5_softdevice_headers)

# Application timer
add_library(nrf5_app_timer OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/timer/app_timer.c"
)
target_include_directories(nrf5_app_timer PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/timer"
)
target_link_libraries(nrf5_app_timer PUBLIC nrf5_app_scheduler nrf5_delay nrf5_nrfx_hal)

# GPIOTE nrfx driver
add_library(nrf5_nrfx_gpiote OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_gpiote.c"
)
target_include_directories(nrf5_nrfx_gpiote PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
  "${NRF5_SDK_PATH}/integration/nrfx/legacy"
)
target_link_libraries(nrf5_nrfx_gpiote PUBLIC nrf5_mdk nrf5_softdevice_headers nrf5_nrfx_common)

# Application button
add_library(nrf5_app_button OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/button/app_button.c"
)
target_include_directories(nrf5_app_button PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/button"
)
target_link_libraries(nrf5_app_button PUBLIC nrf5_app_timer nrf5_nrfx_gpiote)

# Boards
add_library(nrf5_boards OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/boards/boards.c"
)
target_include_directories(nrf5_boards PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/boards"
)
if(NRF5_BOARD)
  target_compile_definitions(nrf5_boards PUBLIC "BOARD_${NRF5_BOARD_UPPER}")
endif()
target_link_libraries(nrf5_boards PUBLIC nrf5_mdk nrf5_softdevice_headers nrf5_nrfx_hal)

# Board Support Package
add_library(nrf5_bsp OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bsp/bsp.c"
)
target_include_directories(nrf5_bsp PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bsp"
)
target_link_libraries(nrf5_bsp PUBLIC nrf5_boards nrf5_app_button)

# A common set of libraries most other libraries depend on
add_library(nrf5_common_libs INTERFACE)
target_include_directories(nrf5_common_libs INTERFACE
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_common_libs INTERFACE nrf5_config nrf5_app_error nrf5_log)

add_library(nrf5_nrfx_common INTERFACE)
target_include_directories(nrf5_nrfx_common INTERFACE
  "${NRF5_SDK_PATH}/modules/nrfx"
  "${NRF5_SDK_PATH}/integration/nrfx"
)
target_compile_definitions(nrf5_nrfx_common INTERFACE
  SOFTDEVICE_PRESENT
)
target_link_libraries(nrf5_nrfx_common INTERFACE nrf5_config)

add_library(nrf5_nrfx_hal INTERFACE)
target_include_directories(nrf5_nrfx_hal INTERFACE
  "${NRF5_SDK_PATH}/modules/nrfx/hal"
)
target_link_libraries(nrf5_nrfx_hal INTERFACE nrf5_nrfx_common)

add_library(nrf5_delay INTERFACE)
target_include_directories(nrf5_delay INTERFACE
  "${NRF5_SDK_PATH}/components/libraries/delay")

# BLE common
add_library(nrf5_ble_common OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/common/ble_srv_common.c"
)
target_include_directories(nrf5_ble_common PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/ble/common"
)
target_link_libraries(nrf5_ble_common PUBLIC nrf5_mdk nrf5_softdevice_headers)

# SoftDevice Handler
add_library(nrf5_softdevice_handler OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/softdevice/common/nrf_sdh.c"
  "${NRF5_SDK_PATH}/components/softdevice/common/nrf_sdh_ble.c"
  "${NRF5_SDK_PATH}/components/softdevice/common/nrf_sdh_soc.c"
)
target_include_directories(nrf5_softdevice_handler PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/softdevice/common"
)
target_link_libraries(nrf5_softdevice_handler PUBLIC nrf5_log)

# BLE LBS service
add_library(nrf5_ble_srv_lbs OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_lbs/ble_lbs.c"
)
target_include_directories(nrf5_ble_srv_lbs PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_lbs"
)
target_link_libraries(nrf5_ble_srv_lbs PUBLIC nrf5_config nrf5_ble_common nrf5_softdevice_handler)

function(nrf5_target exec_target)
  # nrf5_mdk must be linked as startup_*.S contains definition of the Reset_Handler entry symbol 
  target_link_libraries(${exec_target} PRIVATE nrf5_common_libs nrf5_mdk)
  target_link_options(${exec_target} PRIVATE
    "-L${NRF5_SDK_PATH}/modules/nrfx/mdk"
    "-T${NRF5_LINKER_SCRIPT}"
  )
  # targets for creating Intel HEX and binary executable forms
  add_custom_target(hex DEPENDS ${exec_target} COMMAND ${CMAKE_OBJCOPY_BIN} -O ihex "${exec_target}" "${exec_target}.hex")
  add_custom_target(bin DEPENDS ${exec_target} COMMAND ${CMAKE_OBJCOPY_BIN} -O binary "${exec_target}" "${exec_target}.bin")
  # target for flashing SoftDevice
  add_custom_target(flash_softdevice
    COMMAND ${NRF5_NRFJPROG} --program ${NRF5_SOFTDEVICE_HEX} -f nrf52 --sectorerase
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
