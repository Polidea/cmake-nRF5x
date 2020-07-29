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

# BLE common
add_library(nrf5_ble_common OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/common/ble_advdata.c"
  "${NRF5_SDK_PATH}/components/ble/common/ble_conn_params.c"
  "${NRF5_SDK_PATH}/components/ble/common/ble_conn_state.c"
  "${NRF5_SDK_PATH}/components/ble/common/ble_srv_common.c"
)
target_include_directories(nrf5_ble_common PUBLIC
  "${NRF5_SDK_PATH}/components/ble/common"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_ble_common PUBLIC
  nrf5_app_timer_fwd
  nrf5_atflags
  nrf5_atomic
  nrf5_config
  nrf5_mdk
  nrf5_sdh
  nrf5_soc
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_COMMON_DEPENDENCIES
  nrf5_app_error
  nrf5_app_scheduler
  nrf5_app_timer_fwd
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atflags
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_ble_common
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

# BLE advertising
add_library(nrf5_ble_advertising OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_advertising/ble_advertising.c"
)
target_include_directories(nrf5_ble_advertising PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_advertising"
)
target_link_libraries(nrf5_ble_advertising PUBLIC
  nrf5_ble_common
  nrf5_log
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_ADVERTISING_DEPENDENCIES
  nrf5_app_error
  nrf5_app_scheduler
  nrf5_app_timer_fwd
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atflags
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_ble_advertising
  nrf5_ble_common
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

# BLE scanning
add_library(nrf5_ble_scan OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/nrf_ble_scan/nrf_ble_scan.c"
)
target_include_directories(nrf5_ble_scan PUBLIC
  "${NRF5_SDK_PATH}/components/ble/nrf_ble_scan"
)
target_link_libraries(nrf5_ble_scan PUBLIC
  nrf5_ble_common
  nrf5_log
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_SCAN_DEPENDENCIES
  nrf5_app_error
  nrf5_app_scheduler
  nrf5_app_timer_fwd
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atflags
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_ble_common
  nrf5_ble_scan
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

# BLE data base discovery
add_library(nrf5_ble_db_discovery OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_db_discovery/ble_db_discovery.c"
)
target_include_directories(nrf5_ble_db_discovery PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_db_discovery"
)
target_link_libraries(nrf5_ble_db_discovery PUBLIC
  nrf5_ble_common
  nrf5_log
)
if(NRF5_SDK_VERSION VERSION_EQUAL 16.0.0)
  
  target_link_libraries(nrf5_ble_db_discovery PUBLIC
    nrf5_ble_gq
  )
endif()
list(APPEND NRF5_LIBRARY_NRF5_BLE_DB_DISCOVERY_DEPENDENCIES
  nrf5_app_error
  nrf5_app_scheduler
  nrf5_app_timer_fwd
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atflags
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_ble_common
  nrf5_ble_db_discovery
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
if(NRF5_SDK_VERSION VERSION_EQUAL 16.0.0)
  list(APPEND NRF5_LIBRARY_NRF5_BLE_DB_DISCOVERY_DEPENDENCIES
    nrf5_ble_gq
  )
endif()

# BLE GATT
add_library(nrf5_ble_gatt OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/nrf_ble_gatt/nrf_ble_gatt.c"
)
target_include_directories(nrf5_ble_gatt PUBLIC
  "${NRF5_SDK_PATH}/components/ble/nrf_ble_gatt"
)
target_link_libraries(nrf5_ble_gatt PUBLIC
  nrf5_log
  nrf5_strerror
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_GATT_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_ble_gatt
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
  nrf5_nrfx_hal
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# BLE Queued Writes
add_library(nrf5_ble_qwr OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/nrf_ble_qwr/nrf_ble_qwr.c"
)
target_include_directories(nrf5_ble_qwr PUBLIC
  "${NRF5_SDK_PATH}/components/ble/nrf_ble_qwr"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_ble_qwr PUBLIC
  nrf5_ble_common
  nrf5_config
  nrf5_mdk
  nrf5_soc
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_QWR_DEPENDENCIES
  nrf5_app_error
  nrf5_app_scheduler
  nrf5_app_timer_fwd
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atflags
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_ble_common
  nrf5_ble_qwr
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

# BLE Link Context Manager
add_library(nrf5_ble_link_ctx_manager OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_link_ctx_manager/ble_link_ctx_manager.c"
)
target_include_directories(nrf5_ble_link_ctx_manager PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_link_ctx_manager"
)
target_link_libraries(nrf5_ble_link_ctx_manager PUBLIC
  nrf5_ble_common
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_LINK_CTX_MANAGER_DEPENDENCIES
  nrf5_app_error
  nrf5_app_scheduler
  nrf5_app_timer_fwd
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atflags
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_ble_common
  nrf5_ble_link_ctx_manager
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

# BLE GATT Queue library
if(NRF5_SDK_VERSION VERSION_GREATER_EQUAL 16.0.0)
  add_library(nrf5_ble_gq OBJECT EXCLUDE_FROM_ALL
    "${NRF5_SDK_PATH}/components/ble/nrf_ble_gq/nrf_ble_gq.c"
  )
  target_include_directories(nrf5_ble_gq PUBLIC
    "${NRF5_SDK_PATH}/components/ble/nrf_ble_gq"
  )
  target_link_libraries(nrf5_ble_gq PUBLIC
    nrf5_ble_common
    nrf5_memobj
    nrf5_queue
  )
  if(NRF5_SDK_VERSION VERSION_EQUAL 16.0.0)
    list(APPEND NRF5_LIBRARY_NRF5_BLE_GQ_DEPENDENCIES
      nrf5_app_error
      nrf5_app_scheduler
      nrf5_app_timer_fwd
      nrf5_app_util_platform
      nrf5_atfifo
      nrf5_atflags
      nrf5_atomic
      nrf5_balloc
      nrf5_balloc_fwd
      nrf5_ble_common
      nrf5_ble_gq
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
  endif()
endif()

# BLE Record Access Control Point library
add_library(nrf5_ble_racp OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_racp/ble_racp.c"
)
target_include_directories(nrf5_ble_racp PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_racp"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_ble_racp PUBLIC
  nrf5_config
  nrf5_mdk
  nrf5_soc
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_RACP_DEPENDENCIES
  nrf5_ble_racp
  nrf5_config
  nrf5_mdk
  nrf5_soc
)
