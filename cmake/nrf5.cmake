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

# CC310 library forwarding interface (external, include directories only)
add_library(nrf5_ext_cc310_fwd INTERFACE)
target_include_directories(nrf5_ext_cc310_fwd INTERFACE
  "${NRF5_SDK_PATH}/external/nrf_cc310/include"
)

# mbedTLS library forwarding interface (external, include directories only)
add_library(nrf5_ext_mbedtls_fwd INTERFACE)
target_include_directories(nrf5_ext_mbedtls_fwd INTERFACE
  "${NRF5_SDK_PATH}/external/mbedtls/include"
)

# nRF Crypto forwarding interface (include directories only)
add_library(nrf5_crypto_fwd INTERFACE)
target_include_directories(nrf5_crypto_fwd INTERFACE
  "${NRF5_SDK_PATH}/components/libraries/crypto"
)

# Crypto CC310 backend
add_library(nrf5_crypto_cc310_backend OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_aes.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_aes_aead.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_chacha_poly_aead.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_ecc.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_ecdh.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_ecdsa.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_eddsa.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_hash.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_hmac.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_init.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_mutex.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_rng.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_shared.c"
)
target_include_directories(nrf5_crypto_cc310_backend PUBLIC
"${NRF5_SDK_PATH}/components/libraries/util"
"${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310"
)
target_link_libraries(nrf5_crypto_cc310_backend PUBLIC nrf5_mtx nrf5_nrfx_common nrf5_ext_cc310_fwd)

# Crypto CC310 BL backend
add_library(nrf5_crypto_cc310_bl_backend OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310_bl/cc310_bl_backend_ecc.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310_bl/cc310_bl_backend_ecdsa.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310_bl/cc310_bl_backend_hash.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310_bl/cc310_bl_backend_init.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310_bl/cc310_bl_backend_shared.c"
)
target_include_directories(nrf5_crypto_cc310_bl_backend PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310_bl"
)
target_link_libraries(nrf5_crypto_cc310_bl_backend PUBLIC nrf5_config nrf5_mdk nrf5_soc)

# Crypto Cifra backend
add_library(nrf5_crypto_cifra_backend OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cifra/cifra_backend_aes_aead.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cifra/cifra_backend_aes_aead.c"
)
target_include_directories(nrf5_crypto_cifra_backend PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cifra"
)
target_link_libraries(nrf5_crypto_cifra_backend PUBLIC nrf5_config nrf5_mdk nrf5_soc)

# Crypto mbedTLS backend
add_library(nrf5_crypto_mbedtls_backend OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/mbedtls/mbedtls_backend_aes.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/mbedtls/mbedtls_backend_aes_aead.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/mbedtls/mbedtls_backend_ecc.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/mbedtls/mbedtls_backend_ecdh.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/mbedtls/mbedtls_backend_ecdsa.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/mbedtls/mbedtls_backend_hash.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/mbedtls/mbedtls_backend_hmac.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/mbedtls/mbedtls_backend_init.c"
)
target_include_directories(nrf5_crypto_mbedtls_backend PUBLIC
"${NRF5_SDK_PATH}/components/libraries/util"
"${NRF5_SDK_PATH}/components/libraries/crypto/backend/mbedtls"
)
target_link_libraries(nrf5_crypto_mbedtls_backend PUBLIC nrf5_mdk nrf5_soc nrf5_nrfx_common nrf5_crypto_fwd nrf5_ext_mbedtls_fwd)

# Crypto micro-ecc backend
add_library(nrf5_crypto_micro_ecc_backend OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/micro_ecc/micro_ecc_backend_ecc.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/micro_ecc/micro_ecc_backend_ecdh.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/micro_ecc/micro_ecc_backend_ecdsa.c"
)
target_include_directories(nrf5_crypto_micro_ecc_backend PUBLIC
"${NRF5_SDK_PATH}/components/libraries/util"
"${NRF5_SDK_PATH}/components/libraries/crypto/backend/micro_ecc"
)
target_link_libraries(nrf5_crypto_micro_ecc_backend PUBLIC nrf5_config nrf5_mdk nrf5_soc)

# Crypto Oberon backend
add_library(nrf5_crypto_oberon_backend OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/oberon/oberon_backend_chacha_poly_aead.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/oberon/oberon_backend_ecc.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/oberon/oberon_backend_ecdh.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/oberon/oberon_backend_ecdsa.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/oberon/oberon_backend_eddsa.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/oberon/oberon_backend_hash.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/oberon/oberon_backend_hmac.c"
)
target_include_directories(nrf5_crypto_oberon_backend PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/oberon"
)
target_link_libraries(nrf5_crypto_oberon_backend PUBLIC nrf5_config nrf5_mdk nrf5_soc)

# Crypto nRF HW backend
add_library(nrf5_crypto_nrf_hw_backend OBJECT EXCLUDE_FROM_ALL
"${NRF5_SDK_PATH}/components/libraries/crypto/backend/nrf_hw/nrf_hw_backend_init.c"
"${NRF5_SDK_PATH}/components/libraries/crypto/backend/nrf_hw/nrf_hw_backend_rng.c"
"${NRF5_SDK_PATH}/components/libraries/crypto/backend/nrf_hw/nrf_hw_backend_rng_mbedtls.c"
)
target_include_directories(nrf5_crypto_nrf_hw_backend PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/nrf_hw"
)
target_link_libraries(nrf5_crypto_nrf_hw_backend PUBLIC nrf5_config nrf5_mdk nrf5_soc)

# Crypto nRF SW backend
add_library(nrf5_crypto_nrf_sw_backend OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/nrf_sw/nrf_sw_backend_hash.c"
)
target_include_directories(nrf5_crypto_nrf_sw_backend PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/nrf_sw"
)
target_link_libraries(nrf5_crypto_nrf_sw_backend PUBLIC nrf5_config nrf5_mdk nrf5_soc)

# Crypto Optiga backend
add_library(nrf5_crypto_optiga_backend OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/optiga/optiga_backend_ecc.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/optiga/optiga_backend_ecdh.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/optiga/optiga_backend_ecdsa.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/optiga/optiga_backend_init.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/optiga/optiga_backend_rng.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/optiga/optiga_backend_utils.c"
)
target_include_directories(nrf5_crypto_optiga_backend PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/optiga"
)
target_link_libraries(nrf5_crypto_optiga_backend PUBLIC nrf5_config nrf5_mdk nrf5_soc nrf5_crypto_fwd)

# Crypto
add_library(nrf5_crypto OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_aead.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_aes.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_aes_shared.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_ecc.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_ecdh.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_ecdsa.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_eddsa.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_error.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_hash.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_hkdf.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_hmac.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_init.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_rng.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_shared.c"
)
target_include_directories(nrf5_crypto PUBLIC
"${NRF5_SDK_PATH}/components/libraries/util"
"${NRF5_SDK_PATH}/components/libraries/svc"
"${NRF5_SDK_PATH}/components/libraries/crypto"
)
target_link_libraries(nrf5_crypto PUBLIC
  nrf5_section
  nrf5_log
  nrf5_stack_info
  nrf5_svc
  nrf5_crypto_cc310_backend
  nrf5_crypto_cc310_bl_backend
  nrf5_crypto_cifra_backend
  nrf5_crypto_mbedtls_backend
  nrf5_crypto_micro_ecc_backend
  nrf5_crypto_oberon_backend
  nrf5_crypto_nrf_hw_backend
  nrf5_crypto_nrf_sw_backend
  nrf5_crypto_optiga_backend
)



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

# BLE common
add_library(nrf5_ble_common OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/common/ble_advdata.c"
  "${NRF5_SDK_PATH}/components/ble/common/ble_conn_params.c"
  "${NRF5_SDK_PATH}/components/ble/common/ble_conn_state.c"
  "${NRF5_SDK_PATH}/components/ble/common/ble_srv_common.c"
)
target_include_directories(nrf5_ble_common PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/ble/common"
)
target_link_libraries(nrf5_ble_common PUBLIC nrf5_config nrf5_mdk nrf5_soc nrf5_atomic nrf5_softdevice_handler nrf5_app_timer nrf5_atflags)

# BLE advertising
add_library(nrf5_ble_advertising OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_advertising/ble_advertising.c"
)
target_include_directories(nrf5_ble_advertising PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_advertising"
)
target_link_libraries(nrf5_ble_advertising PUBLIC nrf5_log nrf5_ble_common)

# BLE scanning
add_library(nrf5_ble_scan OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/nrf_ble_scan/nrf_ble_scan.c"
)
target_include_directories(nrf5_ble_scan PUBLIC
  "${NRF5_SDK_PATH}/components/ble/nrf_ble_scan"
)
target_link_libraries(nrf5_ble_scan PUBLIC nrf5_log nrf5_ble_common)

# BLE data base discovery
add_library(nrf5_ble_db_discovery OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_db_discovery/ble_db_discovery.c"
)
target_include_directories(nrf5_ble_db_discovery PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_db_discovery"
)
target_link_libraries(nrf5_ble_db_discovery PUBLIC nrf5_log nrf5_ble_common)

# BLE GATT
add_library(nrf5_ble_gatt OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/nrf_ble_gatt/nrf_ble_gatt.c"
)
target_include_directories(nrf5_ble_gatt PUBLIC
  "${NRF5_SDK_PATH}/components/ble/nrf_ble_gatt"
)
target_link_libraries(nrf5_ble_gatt PUBLIC nrf5_log nrf5_strerror)

# BLE Queued Writes
add_library(nrf5_ble_qwr OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/nrf_ble_qwr/nrf_ble_qwr.c"
)
target_include_directories(nrf5_ble_qwr PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/ble/nrf_ble_qwr"
)
target_link_libraries(nrf5_ble_qwr PUBLIC nrf5_config nrf5_mdk nrf5_soc nrf5_ble_common)

# BLE Link Context Manager
add_library(nrf5_ble_link_ctx_manager OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_link_ctx_manager/ble_link_ctx_manager.c"
)
target_include_directories(nrf5_ble_link_ctx_manager PUBLIC
  "${NRF5_SDK_PATH}/components/ble/ble_link_ctx_manager"
)
target_link_libraries(nrf5_ble_link_ctx_manager PUBLIC nrf5_ble_common)

# BLE LESC
add_library(nrf5_ble_lesc OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/nrf_ble_lesc.c"
)
target_include_directories(nrf5_ble_lesc PUBLIC
"${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
)
target_link_libraries(nrf5_ble_lesc PUBLIC nrf5_config nrf5_mdk nrf5_soc nrf5_crypto_fwd)

# Peer Database
add_library(nrf5_ble_peer_database OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/peer_database.c"
)
target_include_directories(nrf5_ble_peer_database PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
)
target_link_libraries(nrf5_ble_peer_database PUBLIC nrf5_ble_common)

# Peer Data Storage
add_library(nrf5_ble_peer_data_storage OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/peer_data_storage.c"
)
target_include_directories(nrf5_ble_peer_data_storage PUBLIC
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
)
target_link_libraries(nrf5_ble_peer_data_storage PUBLIC nrf5_ble_common)

# ID Manager
add_library(nrf5_ble_id_manager OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/id_manager.c"
)
target_include_directories(nrf5_ble_id_manager PUBLIC
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
)
target_link_libraries(nrf5_ble_id_manager PUBLIC nrf5_ble_common)

# Peer ID
add_library(nrf5_ble_peer_id OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/peer_id.c"
)
target_include_directories(nrf5_ble_peer_id PUBLIC
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
)
target_link_libraries(nrf5_ble_peer_id PUBLIC nrf5_ble_common)

# Peer Manager Buffer
add_library(nrf5_ble_pm_buffer OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/pm_buffer.c"
)
target_include_directories(nrf5_ble_pm_buffer PUBLIC
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
)
target_link_libraries(nrf5_ble_pm_buffer PUBLIC nrf5_ble_common)

# Authorization Status Tracker
add_library(nrf5_ble_auth_status_tracker OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/auth_status_tracker.c"
)
target_include_directories(nrf5_ble_auth_status_tracker PUBLIC
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
)
target_link_libraries(nrf5_ble_auth_status_tracker PUBLIC nrf5_ble_common)

# Security Dispatcher
add_library(nrf5_ble_security_dispatcher OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/security_dispatcher.c"
)
target_include_directories(nrf5_ble_security_dispatcher PUBLIC
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
)
target_link_libraries(nrf5_ble_security_dispatcher PUBLIC nrf5_ble_common)

# Security Manager
add_library(nrf5_ble_security_manager OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/security_manager.c"
)
target_include_directories(nrf5_ble_security_manager PUBLIC
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
)
target_link_libraries(nrf5_ble_security_manager PUBLIC nrf5_ble_common)

# GATT Cache Manager
add_library(nrf5_ble_gatt_cache_manager OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/gatt_cache_manager.c"
  "${NRF5_SDK_PATH}/components/ble/peer_manager/gatts_cache_manager.c"
)
target_include_directories(nrf5_ble_gatt_cache_manager PUBLIC
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
)
target_link_libraries(nrf5_ble_gatt_cache_manager PUBLIC nrf5_ble_common)

# Peer Manager Handler
add_library(nrf5_ble_peer_manager_handler OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/peer_manager_handler.c"
)
target_include_directories(nrf5_ble_peer_manager_handler PUBLIC
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
)
target_link_libraries(nrf5_ble_peer_manager_handler PUBLIC nrf5_ble_common)

# Peer Manager
add_library(nrf5_ble_peer_manager OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/peer_manager/peer_manager.c"
)
target_include_directories(nrf5_ble_peer_manager PUBLIC
  "${NRF5_SDK_PATH}/components/ble/peer_manager"
)
target_link_libraries(nrf5_ble_peer_manager PUBLIC nrf5_ble_common)

# IoT Common
add_library(nrf5_iot_common INTERFACE)
target_include_directories(nrf5_iot_common INTERFACE
  "${NRF5_SDK_PATH}/components/iot/common"
)

# BLE LED Button Service (Peripheral)
add_library(nrf5_ble_srv_lbs OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_lbs/ble_lbs.c"
)
target_include_directories(nrf5_ble_srv_lbs PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/ble/ble_services/ble_lbs"
)
target_link_libraries(nrf5_ble_srv_lbs PUBLIC nrf5_config nrf5_ble_common nrf5_softdevice_handler)

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
