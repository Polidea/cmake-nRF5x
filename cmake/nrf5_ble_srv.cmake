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

# BLE LED Button Service (Peripheral)
add_library(nrf5_ble_srv_lbs OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_lbs/ble_lbs.c"
)
target_include_directories(nrf5_ble_srv_lbs PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_lbs"
)
target_link_libraries(nrf5_ble_srv_lbs PUBLIC nrf5_config nrf5_ble_common nrf5_sdh)

# BLE LED Button Service (Central)
add_library(nrf5_ble_srv_lbs_c OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_lbs_c/ble_lbs_c.c"
)
target_include_directories(nrf5_ble_srv_lbs_c PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_lbs_c"
)
target_link_libraries(nrf5_ble_srv_lbs_c PUBLIC nrf5_ble_db_discovery)

# BLE Nordic UART Service (Peripheral)
add_library(nrf5_ble_srv_nus OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_nus/ble_nus.c"
)
target_include_directories(nrf5_ble_srv_nus PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_nus/"
)
target_link_libraries(nrf5_ble_srv_nus PUBLIC nrf5_ble_link_ctx_manager)

# BLE Nordic UART Service (Central)
add_library(nrf5_ble_srv_nus_c OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_nus_c/ble_nus_c.c"
)
target_include_directories(nrf5_ble_srv_nus_c PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_nus_c/"
)
target_link_libraries(nrf5_ble_srv_nus_c PUBLIC nrf5_ble_db_discovery)

# BLE Device Information Service (Peripheral)
add_library(nrf5_ble_srv_dis OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_dis/ble_dis.c"
)
target_include_directories(nrf5_ble_srv_dis PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_dis/"
)
target_link_libraries(nrf5_ble_srv_dis PUBLIC nrf5_ble_common)

# BLE Bond Management Service
add_library(nrf5_ble_srv_bms OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/nrf_ble_bms/nrf_ble_bms.c"
)
target_include_directories(nrf5_ble_srv_bms PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/ble/ble_services/nrf_ble_bms/"
)
target_link_libraries(nrf5_ble_srv_bms PUBLIC nrf5_ble_common nrf5_ble_qwr)

# BLE Internet Protocol Support Profile Service
add_library(nrf5_ble_srv_ipsp OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_ipsp/ble_ipsp.c"
)
target_include_directories(nrf5_ble_srv_ipsp PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_ipsp/"
)
target_link_libraries(nrf5_ble_srv_ipsp PUBLIC nrf5_ble_common)
