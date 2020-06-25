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
  nrf5_app_scheduler
  nrf5_app_timer
  nrf5_app_util_platform
  nrf5_atflags
  nrf5_atomic
  nrf5_ble_common
  nrf5_ble_srv_lbs
  nrf5_config
  nrf5_delay
  nrf5_log_fwd
  nrf5_mdk
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_sdh
  nrf5_section
  nrf5_soc
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
  nrf5_app_scheduler
  nrf5_app_timer
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
  nrf5_app_scheduler
  nrf5_app_timer
  nrf5_app_util_platform
  nrf5_atflags
  nrf5_atomic
  nrf5_ble_common
  nrf5_ble_link_ctx_manager
  nrf5_ble_srv_nus
  nrf5_config
  nrf5_delay
  nrf5_log_fwd
  nrf5_mdk
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_sdh
  nrf5_section
  nrf5_soc
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
  nrf5_app_scheduler
  nrf5_app_timer
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
  nrf5_app_scheduler
  nrf5_app_timer
  nrf5_app_util_platform
  nrf5_atflags
  nrf5_atomic
  nrf5_ble_common
  nrf5_ble_srv_dis
  nrf5_config
  nrf5_delay
  nrf5_log_fwd
  nrf5_mdk
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_sdh
  nrf5_section
  nrf5_soc
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
  nrf5_app_scheduler
  nrf5_app_timer
  nrf5_app_util_platform
  nrf5_atflags
  nrf5_atomic
  nrf5_ble_common
  nrf5_ble_qwr
  nrf5_ble_srv_bms
  nrf5_config
  nrf5_delay
  nrf5_log_fwd
  nrf5_mdk
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_sdh
  nrf5_section
  nrf5_soc
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
  nrf5_app_scheduler
  nrf5_app_timer
  nrf5_app_util_platform
  nrf5_atflags
  nrf5_atomic
  nrf5_ble_common
  nrf5_ble_srv_ipsp
  nrf5_config
  nrf5_delay
  nrf5_log_fwd
  nrf5_mdk
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_sdh
  nrf5_section
  nrf5_soc
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
  nrf5_app_scheduler
  nrf5_app_timer
  nrf5_app_util_platform
  nrf5_atflags
  nrf5_atomic
  nrf5_ble_common
  nrf5_ble_srv_lls
  nrf5_config
  nrf5_delay
  nrf5_log_fwd
  nrf5_mdk
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_sdh
  nrf5_section
  nrf5_soc
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
  nrf5_app_scheduler
  nrf5_app_timer
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
  nrf5_app_scheduler
  nrf5_app_timer
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
  nrf5_app_scheduler
  nrf5_app_timer
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
  nrf5_app_scheduler
  nrf5_app_timer
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
  nrf5_app_scheduler
  nrf5_app_timer
  nrf5_app_util_platform
  nrf5_atflags
  nrf5_atomic
  nrf5_ble_common
  nrf5_ble_srv_rscs
  nrf5_config
  nrf5_delay
  nrf5_log_fwd
  nrf5_mdk
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_sdh
  nrf5_section
  nrf5_soc
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
  nrf5_app_scheduler
  nrf5_app_timer
  nrf5_app_util_platform
  nrf5_atflags
  nrf5_atomic
  nrf5_ble_common
  nrf5_ble_link_ctx_manager
  nrf5_ble_srv_hids
  nrf5_config
  nrf5_delay
  nrf5_log_fwd
  nrf5_mdk
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_sdh
  nrf5_section
  nrf5_soc
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
  nrf5_app_scheduler
  nrf5_app_timer
  nrf5_app_util_platform
  nrf5_atflags
  nrf5_atomic
  nrf5_ble_common
  nrf5_ble_srv_bas
  nrf5_config
  nrf5_delay
  nrf5_log_fwd
  nrf5_mdk
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_sdh
  nrf5_section
  nrf5_soc
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
  nrf5_app_scheduler
  nrf5_app_timer
  nrf5_app_util_platform
  nrf5_atflags
  nrf5_atomic
  nrf5_ble_common
  nrf5_ble_srv_hts
  nrf5_config
  nrf5_delay
  nrf5_log_fwd
  nrf5_mdk
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)
if(NRF5_SDK_VERSION VERSION_EQUAL 16.0.0)
  list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_HTS_DEPENDENCIES
    nrf5_balloc
    nrf5_balloc_fwd
    nrf5_ble_gq
    nrf5_cli_fwd
    nrf5_ext_fprintf
    nrf5_memobj
    nrf5_memobj_fwd
    nrf5_queue
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
  nrf5_app_scheduler
  nrf5_app_timer
  nrf5_app_util_platform
  nrf5_atflags
  nrf5_atomic
  nrf5_ble_common
  nrf5_ble_srv_bps
  nrf5_config
  nrf5_delay
  nrf5_log_fwd
  nrf5_mdk
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)
if(NRF5_SDK_VERSION VERSION_EQUAL 16.0.0)
  list(APPEND NRF5_LIBRARY_NRF5_BLE_SRV_BPS_DEPENDENCIES
    nrf5_balloc
    nrf5_balloc_fwd
    nrf5_ble_gq
    nrf5_cli_fwd
    nrf5_ext_fprintf
    nrf5_memobj
    nrf5_memobj_fwd
    nrf5_queue
  )
endif()
