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

# BLE LESC
add_library(nrf5_ble_lesc OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/nrf_ble_lesc.c"
)
target_include_directories(nrf5_ble_lesc PUBLIC
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_ble_lesc PUBLIC
  nrf5_config
  nrf5_crypto
  nrf5_log
  nrf5_mdk
  nrf5_soc
)

# Peer Database
add_library(nrf5_ble_peer_database OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/peer_database.c"
)
target_include_directories(nrf5_ble_peer_database PUBLIC
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_ble_peer_database PUBLIC
  nrf5_ble_common
  nrf5_memobj
)

# Peer Data Storage
add_library(nrf5_ble_peer_data_storage OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/peer_data_storage.c"
)
target_include_directories(nrf5_ble_peer_data_storage PUBLIC
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
)
target_link_libraries(nrf5_ble_peer_data_storage PUBLIC
  nrf5_ble_common
  nrf5_fds
  nrf5_memobj
)

# ID Manager
add_library(nrf5_ble_id_manager OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/id_manager.c"
)
target_include_directories(nrf5_ble_id_manager PUBLIC
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
)
target_link_libraries(nrf5_ble_id_manager PUBLIC
  nrf5_ble_common
  nrf5_memobj
)

# Peer ID
add_library(nrf5_ble_peer_id OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/peer_id.c"
)
target_include_directories(nrf5_ble_peer_id PUBLIC
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
)
target_link_libraries(nrf5_ble_peer_id PUBLIC
  nrf5_ble_common
)

# Peer Manager Buffer
add_library(nrf5_ble_pm_buffer OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/pm_buffer.c"
)
target_include_directories(nrf5_ble_pm_buffer PUBLIC
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
)
target_link_libraries(nrf5_ble_pm_buffer PUBLIC
  nrf5_ble_common
)

# Authorization Status Tracker
add_library(nrf5_ble_auth_status_tracker OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/auth_status_tracker.c"
)
target_include_directories(nrf5_ble_auth_status_tracker PUBLIC
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
)
target_link_libraries(nrf5_ble_auth_status_tracker PUBLIC
  nrf5_ble_common
)

# Security Dispatcher
add_library(nrf5_ble_security_dispatcher OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/security_dispatcher.c"
)
target_include_directories(nrf5_ble_security_dispatcher PUBLIC
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
)
target_link_libraries(nrf5_ble_security_dispatcher PUBLIC
  nrf5_ble_common
  nrf5_memobj
)

# Security Manager
add_library(nrf5_ble_security_manager OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/security_manager.c"
)
target_include_directories(nrf5_ble_security_manager PUBLIC
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
)
target_link_libraries(nrf5_ble_security_manager PUBLIC
  nrf5_ble_common
  nrf5_memobj
)

# GATT Cache Manager
add_library(nrf5_ble_gatt_cache_manager OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/gatt_cache_manager.c"
  "${NRF5_SDK_PATH}/components/ble/peer_manager/gatts_cache_manager.c"
)
target_include_directories(nrf5_ble_gatt_cache_manager PUBLIC
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
)
target_link_libraries(nrf5_ble_gatt_cache_manager PUBLIC
  nrf5_ble_common
  nrf5_memobj
  nrf5_mtx
)

# Peer Manager Handler
add_library(nrf5_ble_peer_manager_handler OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/peer_manager_handler.c"
)
target_include_directories(nrf5_ble_peer_manager_handler PUBLIC
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
)
target_link_libraries(nrf5_ble_peer_manager_handler PUBLIC
  nrf5_ble_common
  nrf5_fds
  nrf5_memobj
)

# Peer Manager
add_library(nrf5_ble_peer_manager OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/peer_manager.c"
)
target_include_directories(nrf5_ble_peer_manager PUBLIC
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
)
target_link_libraries(nrf5_ble_peer_manager PUBLIC
  nrf5_ble_common
  nrf5_memobj
)
