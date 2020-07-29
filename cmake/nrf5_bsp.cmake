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
#
# WARNING: FILE GENERATED FROM ./ci/scripts/generate_cmake.sh SCRIPT.

# Boards
add_library(nrf5_boards OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/boards/boards.c"
)
target_include_directories(nrf5_boards PUBLIC
  "${NRF5_SDK_PATH}/components/boards"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_boards PUBLIC
  nrf5_mdk
  nrf5_nrfx_hal
  nrf5_soc
)
list(APPEND NRF5_LIBRARY_NRF5_BOARDS_DEPENDENCIES
  nrf5_boards
  nrf5_config
  nrf5_mdk
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_soc
)

# Board Support Package (definitions only)
add_library(nrf5_bsp_defs INTERFACE)
target_include_directories(nrf5_bsp_defs INTERFACE
  "${NRF5_SDK_PATH}/components/libraries/bsp"
)
target_link_libraries(nrf5_bsp_defs INTERFACE
  nrf5_boards
)
list(APPEND NRF5_LIBRARY_NRF5_BSP_DEFS_DEPENDENCIES
  nrf5_boards
  nrf5_bsp_defs
  nrf5_config
  nrf5_mdk
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_soc
)

# Board Support Package
add_library(nrf5_bsp OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bsp/bsp.c"
)
target_include_directories(nrf5_bsp PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bsp"
)
target_link_libraries(nrf5_bsp PUBLIC
  nrf5_app_button
  nrf5_boards
)
list(APPEND NRF5_LIBRARY_NRF5_BSP_DEPENDENCIES
  nrf5_app_button
  nrf5_app_error
  nrf5_app_scheduler
  nrf5_app_timer_fwd
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_boards
  nrf5_bsp
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_gpiote
  nrf5_nrfx_hal
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_sortlist
  nrf5_strerror
)

# BSP Button BLE
add_library(nrf5_bsp_btn_ble OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bsp/bsp_btn_ble.c"
)
target_include_directories(nrf5_bsp_btn_ble PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bsp"
)
target_link_libraries(nrf5_bsp_btn_ble PUBLIC
  nrf5_bsp
)
list(APPEND NRF5_LIBRARY_NRF5_BSP_BTN_BLE_DEPENDENCIES
  nrf5_app_button
  nrf5_app_error
  nrf5_app_scheduler
  nrf5_app_timer_fwd
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_boards
  nrf5_bsp
  nrf5_bsp_btn_ble
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_gpiote
  nrf5_nrfx_hal
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_sortlist
  nrf5_strerror
)

# BSP over CLI Module
add_library(nrf5_bsp_cli OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bsp/bsp_cli.c"
)
target_include_directories(nrf5_bsp_cli PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bsp"
)
target_link_libraries(nrf5_bsp_cli PUBLIC
  nrf5_bsp
)
list(APPEND NRF5_LIBRARY_NRF5_BSP_CLI_DEPENDENCIES
  nrf5_app_button
  nrf5_app_error
  nrf5_app_scheduler
  nrf5_app_timer_fwd
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_boards
  nrf5_bsp
  nrf5_bsp_cli
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_gpiote
  nrf5_nrfx_hal
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_sortlist
  nrf5_strerror
)
