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

# BLE LED Button Service (Peripheral)
add_library(nrf5_ble_srv_lbs OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_lbs/ble_lbs.c"
)
target_include_directories(nrf5_ble_srv_lbs PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_lbs"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_ble_srv_lbs PUBLIC
  nrf5_ble_common
  nrf5_config
  nrf5_sdh
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_LBS_DEPENDENCIES
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
  nrf5_ble_srv_lbs
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

# BLE LED Button Service (Central)
add_library(nrf5_ble_srv_lbs_c OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_lbs_c/ble_lbs_c.c"
)
target_include_directories(nrf5_ble_srv_lbs_c PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_lbs_c"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_ble_srv_lbs_c PUBLIC
  nrf5_ble_db_discovery
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_LBS_C_DEPENDENCIES
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
  nrf5_ble_srv_lbs_c
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
  list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_LBS_C_DEPENDENCIES
    nrf5_ble_gq
  )
endif()

# BLE Nordic UART Service (Peripheral)
add_library(nrf5_ble_srv_nus OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_nus/ble_nus.c"
)
target_include_directories(nrf5_ble_srv_nus PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_nus"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_ble_srv_nus PUBLIC
  nrf5_ble_link_ctx_manager
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_NUS_DEPENDENCIES
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
  nrf5_ble_srv_nus
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

# BLE Nordic UART Service (Central)
add_library(nrf5_ble_srv_nus_c OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_nus_c/ble_nus_c.c"
)
target_include_directories(nrf5_ble_srv_nus_c PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_nus_c"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_ble_srv_nus_c PUBLIC
  nrf5_ble_db_discovery
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_NUS_C_DEPENDENCIES
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
  nrf5_ble_srv_nus_c
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
  list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_NUS_C_DEPENDENCIES
    nrf5_ble_gq
  )
endif()

# BLE Device Information Service (Peripheral)
add_library(nrf5_ble_srv_dis OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_dis/ble_dis.c"
)
target_include_directories(nrf5_ble_srv_dis PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_dis"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_ble_srv_dis PUBLIC
  nrf5_ble_common
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_DIS_DEPENDENCIES
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
  nrf5_ble_srv_dis
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

# BLE Bond Management Service
add_library(nrf5_ble_srv_bms OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/nrf_ble_bms/nrf_ble_bms.c"
)
target_include_directories(nrf5_ble_srv_bms PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/nrf_ble_bms"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_ble_srv_bms PUBLIC
  nrf5_ble_common
  nrf5_ble_qwr
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_BMS_DEPENDENCIES
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
  nrf5_ble_srv_bms
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

# BLE Internet Protocol Support Profile Service
add_library(nrf5_ble_srv_ipsp OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_ipsp/ble_ipsp.c"
)
target_include_directories(nrf5_ble_srv_ipsp PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_ipsp"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_ble_srv_ipsp PUBLIC
  nrf5_ble_common
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_IPSP_DEPENDENCIES
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
  nrf5_ble_srv_ipsp
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

# BLE Link Loss Service (Peripheral)
add_library(nrf5_ble_srv_lls OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_lls/ble_lls.c"
)
target_include_directories(nrf5_ble_srv_lls PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_lls"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_ble_srv_lls PUBLIC
  nrf5_ble_common
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_LLS_DEPENDENCIES
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
  nrf5_ble_srv_lls
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

# BLE Immediate Alert Service Client (Peripheral)
add_library(nrf5_ble_srv_ias OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_ias/ble_ias.c"
)
target_include_directories(nrf5_ble_srv_ias PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_ias"
)
target_link_libraries(nrf5_ble_srv_ias PUBLIC
  nrf5_ble_common
  nrf5_ble_link_ctx_manager
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_IAS_DEPENDENCIES
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
  nrf5_ble_srv_ias
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

# BLE Immediate Alert Service Client (Central)
add_library(nrf5_ble_srv_ias_c OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_ias_c/ble_ias_c.c"
)
target_include_directories(nrf5_ble_srv_ias_c PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_ias_c"
)
target_link_libraries(nrf5_ble_srv_ias_c PUBLIC
  nrf5_ble_db_discovery
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_IAS_C_DEPENDENCIES
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
  nrf5_ble_srv_ias_c
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
  list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_IAS_C_DEPENDENCIES
    nrf5_ble_gq
  )
endif()

# BLE GATT Service Server (Central)
add_library(nrf5_ble_srv_gatts_c OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/experimental_gatts_c/nrf_ble_gatts_c.c"
)
target_include_directories(nrf5_ble_srv_gatts_c PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/experimental_gatts_c"
)
target_link_libraries(nrf5_ble_srv_gatts_c PUBLIC
  nrf5_ble_db_discovery
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_GATTS_C_DEPENDENCIES
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
  nrf5_ble_srv_gatts_c
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
  list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_GATTS_C_DEPENDENCIES
    nrf5_ble_gq
  )
endif()

# BLE Current Time Service Client (Central)
add_library(nrf5_ble_srv_cts_c OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_cts_c/ble_cts_c.c"
)
target_include_directories(nrf5_ble_srv_cts_c PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_cts_c"
)
target_link_libraries(nrf5_ble_srv_cts_c PUBLIC
  nrf5_ble_db_discovery
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_CTS_C_DEPENDENCIES
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
  nrf5_ble_srv_cts_c
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
  list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_CTS_C_DEPENDENCIES
    nrf5_ble_gq
  )
endif()

# BLE Alert Notification Client (Central)
add_library(nrf5_ble_srv_ans_c OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_ans_c/ble_ans_c.c"
)
target_include_directories(nrf5_ble_srv_ans_c PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_ans_c"
)
target_link_libraries(nrf5_ble_srv_ans_c PUBLIC
  nrf5_ble_db_discovery
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_ANS_C_DEPENDENCIES
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
  nrf5_ble_srv_ans_c
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
  list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_ANS_C_DEPENDENCIES
    nrf5_ble_gq
  )
endif()

# BLE Running Speed and Cadence Service (Peripheral)
add_library(nrf5_ble_srv_rscs OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_rscs/ble_rscs.c"
)
target_include_directories(nrf5_ble_srv_rscs PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_rscs"
)
target_link_libraries(nrf5_ble_srv_rscs PUBLIC
  nrf5_ble_common
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_RSCS_DEPENDENCIES
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
  nrf5_ble_srv_rscs
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

# BLE HID Service
add_library(nrf5_ble_srv_hids OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_hids/ble_hids.c"
)
target_include_directories(nrf5_ble_srv_hids PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_hids"
)
target_link_libraries(nrf5_ble_srv_hids PUBLIC
  nrf5_ble_common
  nrf5_ble_link_ctx_manager
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_HIDS_DEPENDENCIES
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
  nrf5_ble_srv_hids
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

# BLE Battery Service (Peripheral)
add_library(nrf5_ble_srv_bas OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_bas/ble_bas.c"
)
target_include_directories(nrf5_ble_srv_bas PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_bas"
)
target_link_libraries(nrf5_ble_srv_bas PUBLIC
  nrf5_ble_common
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_BAS_DEPENDENCIES
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
  nrf5_ble_srv_bas
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

# BLE Health Thermometer Service
add_library(nrf5_ble_srv_hts OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_hts/ble_hts.c"
)
target_include_directories(nrf5_ble_srv_hts PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_hts"
)
target_link_libraries(nrf5_ble_srv_hts PUBLIC
  nrf5_ble_common
)
if(NRF5_SDK_VERSION VERSION_EQUAL 16.0.0)
  
  target_link_libraries(nrf5_ble_srv_hts PUBLIC
    nrf5_ble_gq
  )
endif()
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_HTS_DEPENDENCIES
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
  nrf5_ble_srv_hts
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
  list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_HTS_DEPENDENCIES
    nrf5_ble_gq
  )
endif()

# BLE Blood Pressure Service (Peripheral)
add_library(nrf5_ble_srv_bps OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_bps/ble_bps.c"
)
target_include_directories(nrf5_ble_srv_bps PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_bps"
)
target_link_libraries(nrf5_ble_srv_bps PUBLIC
  nrf5_ble_common
)
if(NRF5_SDK_VERSION VERSION_EQUAL 16.0.0)
  
  target_link_libraries(nrf5_ble_srv_bps PUBLIC
    nrf5_ble_gq
  )
endif()
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_BPS_DEPENDENCIES
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
  nrf5_ble_srv_bps
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
  list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_BPS_DEPENDENCIES
    nrf5_ble_gq
  )
endif()

# BLE Cycling Speed and Cadence Service
add_library(nrf5_ble_srv_cscs OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_cscs/ble_cscs.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_cscs/ble_sc_ctrlpt.c"
)
target_include_directories(nrf5_ble_srv_cscs PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_cscs"
)
target_link_libraries(nrf5_ble_srv_cscs PUBLIC
  nrf5_ble_common
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_CSCS_DEPENDENCIES
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
  nrf5_ble_srv_cscs
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

# BLE Location and Navigation Service
add_library(nrf5_ble_srv_lns OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/experimental_ble_lns/ble_ln_cp.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/experimental_ble_lns/ble_ln_db.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/experimental_ble_lns/ble_lns.c"
)
target_include_directories(nrf5_ble_srv_lns PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/experimental_ble_lns"
)
target_link_libraries(nrf5_ble_srv_lns PUBLIC
  nrf5_ble_common
)
if(NRF5_SDK_VERSION VERSION_EQUAL 16.0.0)
  
  target_link_libraries(nrf5_ble_srv_lns PUBLIC
    nrf5_ble_gq
  )
endif()
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_LNS_DEPENDENCIES
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
  nrf5_ble_srv_lns
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
  list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_LNS_DEPENDENCIES
    nrf5_ble_gq
  )
endif()

# BLE Heart Rate Service (Peripheral)
add_library(nrf5_ble_srv_hrs OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_hrs/ble_hrs.c"
)
target_include_directories(nrf5_ble_srv_hrs PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_hrs"
)
target_link_libraries(nrf5_ble_srv_hrs PUBLIC
  nrf5_ble_common
  nrf5_ble_gatt
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_HRS_DEPENDENCIES
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
  nrf5_ble_gatt
  nrf5_ble_srv_hrs
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

# BLE TX Power Service
add_library(nrf5_ble_srv_tps OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_tps/ble_tps.c"
)
target_include_directories(nrf5_ble_srv_tps PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_tps"
)
target_link_libraries(nrf5_ble_srv_tps PUBLIC
  nrf5_ble_common
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_TPS_DEPENDENCIES
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
  nrf5_ble_srv_tps
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

# BLE Glucose Service
add_library(nrf5_ble_srv_gls OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_gls/ble_gls.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_gls/ble_gls_db.c"
)
target_include_directories(nrf5_ble_srv_gls PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_gls"
)
target_link_libraries(nrf5_ble_srv_gls PUBLIC
  nrf5_ble_common
  nrf5_ble_racp
)
if(NRF5_SDK_VERSION VERSION_EQUAL 16.0.0)
  
  target_link_libraries(nrf5_ble_srv_gls PUBLIC
    nrf5_ble_gq
  )
endif()
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_GLS_DEPENDENCIES
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
  nrf5_ble_racp
  nrf5_ble_srv_gls
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
  list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_GLS_DEPENDENCIES
    nrf5_ble_gq
  )
endif()

# BLE Apple Notification Center Service
add_library(nrf5_ble_srv_ancs_c OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_ancs_c/ancs_app_attr_get.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_ancs_c/ancs_attr_parser.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_ancs_c/nrf_ble_ancs_c.c"
)
target_include_directories(nrf5_ble_srv_ancs_c PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_ancs_c"
)
target_link_libraries(nrf5_ble_srv_ancs_c PUBLIC
  nrf5_ble_db_discovery
)
if(NRF5_SDK_VERSION VERSION_EQUAL 15.3.0)
  target_sources(nrf5_ble_srv_ancs_c PRIVATE
    "${NRF5_SDK_PATH}/components/ble/ble_services/ble_ancs_c/ancs_tx_buffer.c"
  )
endif()
if(NRF5_SDK_VERSION VERSION_EQUAL 16.0.0)
  
  target_link_libraries(nrf5_ble_srv_ancs_c PUBLIC
    nrf5_ble_gq
  )
endif()
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_ANCS_C_DEPENDENCIES
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
  nrf5_ble_srv_ancs_c
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
  list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_ANCS_C_DEPENDENCIES
    nrf5_ble_gq
  )
endif()

# BLE Object Transfer Service
add_library(nrf5_ble_srv_ots OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/experimental_ble_ots/ble_ots.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/experimental_ble_ots/ble_ots_l2cap.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/experimental_ble_ots/ble_ots_oacp.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/experimental_ble_ots/ble_ots_object.c"
)
target_include_directories(nrf5_ble_srv_ots PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/experimental_ble_ots"
)
target_link_libraries(nrf5_ble_srv_ots PUBLIC
  nrf5_ble_common
  nrf5_crc32
  nrf5_fds
)
if(NRF5_SDK_VERSION VERSION_EQUAL 15.3.0)
  target_sources(nrf5_ble_srv_ots PRIVATE
    "${NRF5_SDK_PATH}/components/ble/ble_services/experimental_ble_ots/ble_hvx_buffering.c"
  )
endif()
if(NRF5_SDK_VERSION VERSION_EQUAL 16.0.0)
  
  target_link_libraries(nrf5_ble_srv_ots PUBLIC
    nrf5_ble_gq
  )
endif()
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_OTS_DEPENDENCIES
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
  nrf5_ble_srv_ots
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_crc32
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
  list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_OTS_DEPENDENCIES
    nrf5_ble_gq
  )
endif()

# BLE Continuous Glucose Monitoring Service
add_library(nrf5_ble_srv_cgms OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/experimental_nrf_ble_cgms/cgms_db.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/experimental_nrf_ble_cgms/cgms_meas.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/experimental_nrf_ble_cgms/cgms_racp.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/experimental_nrf_ble_cgms/cgms_socp.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/experimental_nrf_ble_cgms/cgms_sst.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/experimental_nrf_ble_cgms/nrf_ble_cgms.c"
)
target_include_directories(nrf5_ble_srv_cgms PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/experimental_nrf_ble_cgms"
)
target_link_libraries(nrf5_ble_srv_cgms PUBLIC
  nrf5_ble_common
  nrf5_ble_racp
)
if(NRF5_SDK_VERSION VERSION_EQUAL 16.0.0)
  
  target_link_libraries(nrf5_ble_srv_cgms PUBLIC
    nrf5_ble_gq
  )
endif()
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_CGMS_DEPENDENCIES
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
  nrf5_ble_racp
  nrf5_ble_srv_cgms
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
  list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_CGMS_DEPENDENCIES
    nrf5_ble_gq
  )
endif()

# BLE Eddystone library
add_library(nrf5_ble_srv_eddystone OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_escs/nrf_ble_escs.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/eddystone/es_adv.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/eddystone/es_adv_frame.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/eddystone/es_adv_timing.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/eddystone/es_adv_timing_resolver.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/eddystone/es_battery_voltage_saadc.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/eddystone/es_flash.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/eddystone/es_gatts.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/eddystone/es_gatts_read.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/eddystone/es_gatts_write.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/eddystone/es_security.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/eddystone/es_slot.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/eddystone/es_slot_reg.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/eddystone/es_stopwatch.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/eddystone/es_tlm.c"
  "${NRF5_SDK_PATH}/components/ble/ble_services/eddystone/nrf_ble_es.c"
)
target_include_directories(nrf5_ble_srv_eddystone PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_escs"
  "${NRF5_SDK_PATH}/components/ble/ble_services/eddystone"
)
target_link_libraries(nrf5_ble_srv_eddystone PUBLIC
  nrf5_app_scheduler
  nrf5_ble_common
  nrf5_crypto
  nrf5_crypto_cifra_backend
  nrf5_crypto_mbedtls_backend
  nrf5_crypto_nrf_hw_backend
  nrf5_crypto_oberon_backend
  nrf5_drv_saadc
  nrf5_fds
)
list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_EDDYSTONE_DEPENDENCIES
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
  nrf5_ble_srv_eddystone
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_crypto
  nrf5_crypto_cifra_backend
  nrf5_crypto_mbedtls_backend
  nrf5_crypto_nrf_hw_backend
  nrf5_crypto_oberon_backend
  nrf5_delay
  nrf5_drv_rng
  nrf5_drv_saadc
  nrf5_ext_cc310_bl_fwd
  nrf5_ext_cc310_fwd
  nrf5_ext_cifra_aes128_eax
  nrf5_ext_cifra_aes128_eax_fwd
  nrf5_ext_fprintf
  nrf5_ext_mbedcrypto
  nrf5_ext_mbedtls
  nrf5_ext_mbedtls_fwd
  nrf5_ext_mbedx509
  nrf5_ext_micro_ecc_fwd
  nrf5_ext_oberon_fwd
  nrf5_ext_optiga_fwd
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_mem_manager
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_rng
  nrf5_nrfx_saadc
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_sha256_fwd
  nrf5_soc
  nrf5_sortlist
  nrf5_stack_info
  nrf5_strerror
)
