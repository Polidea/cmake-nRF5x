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

cmake_minimum_required(VERSION 3.14)
project(ble_app_eddystone LANGUAGES C ASM)

include("nrf5")

add_executable(${CMAKE_PROJECT_NAME}
  "${NRF5_SDK_PATH}/examples/ble_peripheral/ble_app_eddystone/main.c"
)

# Patch eddystone lib
target_include_directories(nrf5_ble_srv_eddystone PRIVATE
  "${NRF5_SDK_PATH}/examples/ble_peripheral/ble_app_eddystone"
)
target_link_libraries(nrf5_ble_srv_eddystone PRIVATE
  nrf5_boards
)

# Example global definitions
add_compile_definitions(
  NRFX_COREDEP_DELAY_US_LOOP_CYCLES=3
  NRF_CRYPTO_MAX_INSTANCE_COUNT=1
  uECC_ENABLE_VLI_API=0
  uECC_SQUARE_FUNC=0
  uECC_SUPPORT_COMPRESSED_POINT=0
  uECC_VLI_NATIVE_LITTLE_ENDIAN=1
)

nrf5_target(${CMAKE_PROJECT_NAME})
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
  nrf5_app_button
  nrf5_app_error
  nrf5_app_scheduler
  nrf5_app_timer
  nrf5_app_util_platform
  nrf5_assert
  nrf5_atfifo
  nrf5_atflags
  nrf5_atomic
  nrf5_balloc
  nrf5_ble_advertising
  nrf5_ble_common
  nrf5_ble_gatt
  nrf5_ble_srv_eddystone
  nrf5_boards
  nrf5_bsp
  nrf5_bsp_btn_ble
  nrf5_crc16
  nrf5_crypto
  nrf5_crypto_cc310_backend
  nrf5_crypto_cifra_backend
  nrf5_crypto_mbedtls_backend
  nrf5_crypto_micro_ecc_backend
  nrf5_crypto_nrf_hw_backend
  nrf5_crypto_oberon_backend
  nrf5_drv_clock
  nrf5_drv_rng
  nrf5_drv_uart
  nrf5_ext_cifra_aes128_eax
  nrf5_ext_fprintf
  nrf5_ext_mbedcrypto
  nrf5_ext_mbedtls
  nrf5_ext_mbedx509
  nrf5_ext_segger_rtt
  nrf5_ext_utf_converter
  nrf5_fds
  nrf5_fstorage
  nrf5_fstorage_nvmc
  nrf5_fstorage_sd
  nrf5_hardfault
  nrf5_log
  nrf5_log_backend_rtt
  nrf5_log_backend_serial
  nrf5_log_backend_uart
  nrf5_log_default_backends
  nrf5_mdk
  nrf5_mem_manager
  nrf5_memobj
  nrf5_nrfx_clock
  nrf5_nrfx_gpiote
  nrf5_nrfx_nvmc
  nrf5_nrfx_prs
  nrf5_nrfx_rng
  nrf5_nrfx_saadc
  nrf5_nrfx_soc
  nrf5_nrfx_uart
  nrf5_nrfx_uarte
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_sensorsim
  nrf5_sortlist
  nrf5_strerror
)