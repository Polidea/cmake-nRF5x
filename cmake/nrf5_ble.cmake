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
  nrf5_app_timer
  nrf5_atflags
  nrf5_atomic
  nrf5_config
  nrf5_mdk
  nrf5_sdh
  nrf5_soc
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
