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

# Automatically generated DFU protocol definitions for nanopb
add_library(nrf5_dfu_cc_pb OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu/dfu-cc.pb.c"
)
target_include_directories(nrf5_dfu_cc_pb PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu"
)
target_link_libraries(nrf5_dfu_cc_pb PUBLIC
  nrf5_ext_nanopb
)
list(APPEND NRF5_LIBRARY_NRF5_DFU_CC_PB_DEPENDENCIES
  nrf5_dfu_cc_pb
  nrf5_ext_nanopb
)

# DFU Flash operations
add_library(nrf5_dfu_flash OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu/nrf_dfu_flash.c"
)
target_include_directories(nrf5_dfu_flash PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu"
)
target_link_libraries(nrf5_dfu_flash PUBLIC
  nrf5_fstorage
  nrf5_log
)
list(APPEND NRF5_LIBRARY_NRF5_DFU_FLASH_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_dfu_flash
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

# DFU global settings
add_library(nrf5_dfu_settings OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu/nrf_dfu_settings.c"
)
target_include_directories(nrf5_dfu_settings PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu"
)
target_link_libraries(nrf5_dfu_settings PUBLIC
  nrf5_crc32
  nrf5_dfu_flash
  nrf5_nrfx_nvmc
)
list(APPEND NRF5_LIBRARY_NRF5_DFU_SETTINGS_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_crc32
  nrf5_delay
  nrf5_dfu_flash
  nrf5_dfu_settings
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
  nrf5_nrfx_nvmc
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# DFU global settings (SVCI)
add_library(nrf5_dfu_settings_svci OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu/nrf_dfu_settings_svci.c"
)
target_include_directories(nrf5_dfu_settings_svci PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu"
)
target_link_libraries(nrf5_dfu_settings_svci PUBLIC
  nrf5_dfu_settings
)
list(APPEND NRF5_LIBRARY_NRF5_DFU_SETTINGS_SVCI_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_crc32
  nrf5_delay
  nrf5_dfu_flash
  nrf5_dfu_settings
  nrf5_dfu_settings_svci
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
  nrf5_nrfx_nvmc
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# USB DFU trigger library
add_library(nrf5_dfu_trigger_usb OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu/nrf_dfu_trigger_usb.c"
)
target_include_directories(nrf5_dfu_trigger_usb PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu"
)
target_link_libraries(nrf5_dfu_trigger_usb PUBLIC
  nrf5_app_usbd
  nrf5_app_usbd_nrf_dfu_trigger
  nrf5_app_usbd_serial_num
  nrf5_boards
  nrf5_log
  nrf5_nrfx_hal
)
list(APPEND NRF5_LIBRARY_NRF5_DFU_TRIGGER_USB_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_usbd
  nrf5_app_usbd_nrf_dfu_trigger
  nrf5_app_usbd_serial_num
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_block_dev
  nrf5_boards
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_dfu_trigger_usb
  nrf5_drv_clock
  nrf5_drv_power
  nrf5_drv_usbd
  nrf5_ext_fprintf
  nrf5_ext_utf_converter
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_clock
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_power
  nrf5_nrfx_soc
  nrf5_nrfx_systick
  nrf5_nrfx_usbd
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# DFU version validation
add_library(nrf5_dfu_ver_validation OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu/nrf_dfu_ver_validation.c"
)
target_include_directories(nrf5_dfu_ver_validation PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bootloader"
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu"
)
target_link_libraries(nrf5_dfu_ver_validation PUBLIC
  nrf5_assert
  nrf5_crypto
  nrf5_dfu_cc_pb
  nrf5_dfu_settings
  nrf5_log
)
list(APPEND NRF5_LIBRARY_NRF5_DFU_VER_VALIDATION_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_assert
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_crc32
  nrf5_crypto
  nrf5_delay
  nrf5_dfu_cc_pb
  nrf5_dfu_flash
  nrf5_dfu_settings
  nrf5_dfu_ver_validation
  nrf5_ext_cc310_bl_fwd
  nrf5_ext_cc310_fwd
  nrf5_ext_cifra_aes128_eax_fwd
  nrf5_ext_fprintf
  nrf5_ext_mbedtls_fwd
  nrf5_ext_micro_ecc_fwd
  nrf5_ext_nanopb
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
  nrf5_nrfx_nvmc
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_sha256_fwd
  nrf5_soc
  nrf5_stack_info
  nrf5_strerror
)

# DFU utilities
add_library(nrf5_dfu_utils OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu/nrf_dfu_utils.c"
)
target_include_directories(nrf5_dfu_utils PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bootloader"
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu"
)
target_link_libraries(nrf5_dfu_utils PUBLIC
  nrf5_app_util_platform
  nrf5_crc32
  nrf5_dfu_settings
  nrf5_ext_nanopb
  nrf5_log
)
list(APPEND NRF5_LIBRARY_NRF5_DFU_UTILS_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_crc32
  nrf5_delay
  nrf5_dfu_flash
  nrf5_dfu_settings
  nrf5_dfu_utils
  nrf5_ext_fprintf
  nrf5_ext_nanopb
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
  nrf5_nrfx_nvmc
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# DFU validation
add_library(nrf5_dfu_validation OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu/nrf_dfu_validation.c"
)
target_include_directories(nrf5_dfu_validation PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bootloader"
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu"
)
target_link_libraries(nrf5_dfu_validation PUBLIC
  nrf5_assert
  nrf5_crc32
  nrf5_crypto
  nrf5_dfu_flash
  nrf5_dfu_settings
  nrf5_dfu_utils
  nrf5_dfu_ver_validation
  nrf5_ext_nanopb
  nrf5_log
  nrf5_strerror
)
list(APPEND NRF5_LIBRARY_NRF5_DFU_VALIDATION_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_assert
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_crc32
  nrf5_crypto
  nrf5_delay
  nrf5_dfu_cc_pb
  nrf5_dfu_flash
  nrf5_dfu_settings
  nrf5_dfu_utils
  nrf5_dfu_validation
  nrf5_dfu_ver_validation
  nrf5_ext_cc310_bl_fwd
  nrf5_ext_cc310_fwd
  nrf5_ext_cifra_aes128_eax_fwd
  nrf5_ext_fprintf
  nrf5_ext_mbedtls_fwd
  nrf5_ext_micro_ecc_fwd
  nrf5_ext_nanopb
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
  nrf5_nrfx_nvmc
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_sha256_fwd
  nrf5_soc
  nrf5_stack_info
  nrf5_strerror
)

# DFU result codes
add_library(nrf5_dfu_handling_error OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu/nrf_dfu_handling_error.c"
)
target_include_directories(nrf5_dfu_handling_error PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu"
)
target_link_libraries(nrf5_dfu_handling_error PUBLIC
  nrf5_log
)
list(APPEND NRF5_LIBRARY_NRF5_DFU_HANDLING_ERROR_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_dfu_handling_error
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

# DFU request handling
add_library(nrf5_dfu_req_handler OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu/nrf_dfu_req_handler.c"
)
target_include_directories(nrf5_dfu_req_handler PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bootloader"
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu"
)
target_link_libraries(nrf5_dfu_req_handler PUBLIC
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_crc32
  nrf5_crypto
  nrf5_dfu_cc_pb
  nrf5_dfu_handling_error
  nrf5_dfu_settings
  nrf5_dfu_utils
  nrf5_dfu_validation
  nrf5_log
)
list(APPEND NRF5_LIBRARY_NRF5_DFU_REQ_HANDLER_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_assert
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_crc32
  nrf5_crypto
  nrf5_delay
  nrf5_dfu_cc_pb
  nrf5_dfu_flash
  nrf5_dfu_handling_error
  nrf5_dfu_req_handler
  nrf5_dfu_settings
  nrf5_dfu_utils
  nrf5_dfu_validation
  nrf5_dfu_ver_validation
  nrf5_ext_cc310_bl_fwd
  nrf5_ext_cc310_fwd
  nrf5_ext_cifra_aes128_eax_fwd
  nrf5_ext_fprintf
  nrf5_ext_mbedtls_fwd
  nrf5_ext_micro_ecc_fwd
  nrf5_ext_nanopb
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
  nrf5_nrfx_nvmc
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_sha256_fwd
  nrf5_soc
  nrf5_stack_info
  nrf5_strerror
)

# DFU transport
add_library(nrf5_dfu_transport OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu/nrf_dfu_transport.c"
)
target_include_directories(nrf5_dfu_transport PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu"
)
target_link_libraries(nrf5_dfu_transport PUBLIC
  nrf5_log
)
list(APPEND NRF5_LIBRARY_NRF5_DFU_TRANSPORT_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_dfu_transport
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

# Master Boot Record API
add_library(nrf5_dfu_mbr OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu/nrf_dfu_mbr.c"
)
target_include_directories(nrf5_dfu_mbr PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bootloader"
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu"
)
target_link_libraries(nrf5_dfu_mbr PUBLIC
  nrf5_log
)
list(APPEND NRF5_LIBRARY_NRF5_DFU_MBR_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_dfu_mbr
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

# DFU initialization
add_library(nrf5_dfu OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu/nrf_dfu.c"
)
target_include_directories(nrf5_dfu PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu"
)
target_link_libraries(nrf5_dfu PUBLIC
  nrf5_dfu_req_handler
  nrf5_dfu_transport
  nrf5_dfu_utils
  nrf5_log
)
list(APPEND NRF5_LIBRARY_NRF5_DFU_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_assert
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_crc32
  nrf5_crypto
  nrf5_delay
  nrf5_dfu
  nrf5_dfu_cc_pb
  nrf5_dfu_flash
  nrf5_dfu_handling_error
  nrf5_dfu_req_handler
  nrf5_dfu_settings
  nrf5_dfu_transport
  nrf5_dfu_utils
  nrf5_dfu_validation
  nrf5_dfu_ver_validation
  nrf5_ext_cc310_bl_fwd
  nrf5_ext_cc310_fwd
  nrf5_ext_cifra_aes128_eax_fwd
  nrf5_ext_fprintf
  nrf5_ext_mbedtls_fwd
  nrf5_ext_micro_ecc_fwd
  nrf5_ext_nanopb
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
  nrf5_nrfx_nvmc
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_sha256_fwd
  nrf5_soc
  nrf5_stack_info
  nrf5_strerror
)

# DFU initialization (SVCI)
add_library(nrf5_dfu_svci OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu/nrf_dfu_svci.c"
)
target_link_libraries(nrf5_dfu_svci PUBLIC
  nrf5_app_util_platform
  nrf5_log
)
list(APPEND NRF5_LIBRARY_NRF5_DFU_SVCI_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_dfu_svci
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

# DFU BLE Service
add_library(nrf5_dfu_ble OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/ble_dfu/nrf_dfu_ble.c"
)
target_include_directories(nrf5_dfu_ble PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bootloader"
  "${NRF5_SDK_PATH}/components/libraries/bootloader/ble_dfu"
)
target_link_libraries(nrf5_dfu_ble PUBLIC
  nrf5_ble_common
  nrf5_dfu_handling_error
  nrf5_dfu_mbr
  nrf5_dfu_req_handler
  nrf5_dfu_settings
  nrf5_dfu_svci
  nrf5_dfu_transport
  nrf5_log
  nrf5_svc
)
list(APPEND NRF5_LIBRARY_NRF5_DFU_BLE_DEPENDENCIES
  nrf5_app_error
  nrf5_app_scheduler
  nrf5_app_timer_fwd
  nrf5_app_util_platform
  nrf5_assert
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
  nrf5_crc32
  nrf5_crypto
  nrf5_delay
  nrf5_dfu_ble
  nrf5_dfu_cc_pb
  nrf5_dfu_flash
  nrf5_dfu_handling_error
  nrf5_dfu_mbr
  nrf5_dfu_req_handler
  nrf5_dfu_settings
  nrf5_dfu_svci
  nrf5_dfu_transport
  nrf5_dfu_utils
  nrf5_dfu_validation
  nrf5_dfu_ver_validation
  nrf5_ext_cc310_bl_fwd
  nrf5_ext_cc310_fwd
  nrf5_ext_cifra_aes128_eax_fwd
  nrf5_ext_fprintf
  nrf5_ext_mbedtls_fwd
  nrf5_ext_micro_ecc_fwd
  nrf5_ext_nanopb
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
  nrf5_nrfx_nvmc
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
  nrf5_svc
)

# DFU Serial transports shared part
add_library(nrf5_dfu_serial OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/serial_dfu/nrf_dfu_serial.c"
)
target_include_directories(nrf5_dfu_serial PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bootloader/serial_dfu"
)
target_link_libraries(nrf5_dfu_serial PUBLIC
  nrf5_dfu_handling_error
  nrf5_dfu_req_handler
  nrf5_dfu_transport
  nrf5_log
)
list(APPEND NRF5_LIBRARY_NRF5_DFU_SERIAL_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_assert
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_crc32
  nrf5_crypto
  nrf5_delay
  nrf5_dfu_cc_pb
  nrf5_dfu_flash
  nrf5_dfu_handling_error
  nrf5_dfu_req_handler
  nrf5_dfu_serial
  nrf5_dfu_settings
  nrf5_dfu_transport
  nrf5_dfu_utils
  nrf5_dfu_validation
  nrf5_dfu_ver_validation
  nrf5_ext_cc310_bl_fwd
  nrf5_ext_cc310_fwd
  nrf5_ext_cifra_aes128_eax_fwd
  nrf5_ext_fprintf
  nrf5_ext_mbedtls_fwd
  nrf5_ext_micro_ecc_fwd
  nrf5_ext_nanopb
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
  nrf5_nrfx_nvmc
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_sha256_fwd
  nrf5_soc
  nrf5_stack_info
  nrf5_strerror
)

# DFU Serial UART
add_library(nrf5_dfu_serial_uart OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/serial_dfu/nrf_dfu_serial_uart.c"
)
target_include_directories(nrf5_dfu_serial_uart PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bootloader/serial_dfu"
)
target_link_libraries(nrf5_dfu_serial_uart PUBLIC
  nrf5_app_util_platform
  nrf5_boards
  nrf5_dfu_serial
  nrf5_drv_uart
  nrf5_log
  nrf5_nrfx_uart
  nrf5_nrfx_uarte
  nrf5_slip
)
list(APPEND NRF5_LIBRARY_NRF5_DFU_SERIAL_UART_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_assert
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_boards
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_crc32
  nrf5_crypto
  nrf5_delay
  nrf5_dfu_cc_pb
  nrf5_dfu_flash
  nrf5_dfu_handling_error
  nrf5_dfu_req_handler
  nrf5_dfu_serial
  nrf5_dfu_serial_uart
  nrf5_dfu_settings
  nrf5_dfu_transport
  nrf5_dfu_utils
  nrf5_dfu_validation
  nrf5_dfu_ver_validation
  nrf5_drv_uart
  nrf5_ext_cc310_bl_fwd
  nrf5_ext_cc310_fwd
  nrf5_ext_cifra_aes128_eax_fwd
  nrf5_ext_fprintf
  nrf5_ext_mbedtls_fwd
  nrf5_ext_micro_ecc_fwd
  nrf5_ext_nanopb
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
  nrf5_nrfx_nvmc
  nrf5_nrfx_prs
  nrf5_nrfx_uart
  nrf5_nrfx_uarte
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_sha256_fwd
  nrf5_slip
  nrf5_soc
  nrf5_stack_info
  nrf5_strerror
)

# DFU Serial USB
add_library(nrf5_dfu_serial_usb OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/serial_dfu/nrf_dfu_serial_usb.c"
)
target_include_directories(nrf5_dfu_serial_usb PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bootloader/serial_dfu"
)
target_link_libraries(nrf5_dfu_serial_usb PUBLIC
  nrf5_app_scheduler
  nrf5_app_usbd
  nrf5_app_usbd_cdc_acm
  nrf5_app_usbd_serial_num
  nrf5_app_util_platform
  nrf5_boards
  nrf5_dfu_serial
  nrf5_drv_clock
  nrf5_drv_power
  nrf5_drv_usbd
  nrf5_log
  nrf5_slip
)
list(APPEND NRF5_LIBRARY_NRF5_DFU_SERIAL_USB_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_usbd
  nrf5_app_usbd_cdc_acm
  nrf5_app_usbd_serial_num
  nrf5_app_util_platform
  nrf5_assert
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_boards
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_crc32
  nrf5_crypto
  nrf5_delay
  nrf5_dfu_cc_pb
  nrf5_dfu_flash
  nrf5_dfu_handling_error
  nrf5_dfu_req_handler
  nrf5_dfu_serial
  nrf5_dfu_serial_usb
  nrf5_dfu_settings
  nrf5_dfu_transport
  nrf5_dfu_utils
  nrf5_dfu_validation
  nrf5_dfu_ver_validation
  nrf5_drv_clock
  nrf5_drv_power
  nrf5_drv_usbd
  nrf5_ext_cc310_bl_fwd
  nrf5_ext_cc310_fwd
  nrf5_ext_cifra_aes128_eax_fwd
  nrf5_ext_fprintf
  nrf5_ext_mbedtls_fwd
  nrf5_ext_micro_ecc_fwd
  nrf5_ext_nanopb
  nrf5_ext_oberon_fwd
  nrf5_ext_optiga_fwd
  nrf5_ext_utf_converter
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_mem_manager
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_clock
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_nvmc
  nrf5_nrfx_power
  nrf5_nrfx_soc
  nrf5_nrfx_systick
  nrf5_nrfx_usbd
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_sha256_fwd
  nrf5_slip
  nrf5_soc
  nrf5_stack_info
  nrf5_strerror
)

# Bootloader info
add_library(nrf5_bootloader_info OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/nrf_bootloader_info.c"
)
target_include_directories(nrf5_bootloader_info PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bootloader"
  "${NRF5_SDK_PATH}/components/libraries/bootloader/dfu"
)
target_link_libraries(nrf5_bootloader_info PUBLIC
  nrf5_nrfx_nvmc
)
list(APPEND NRF5_LIBRARY_NRF5_BOOTLOADER_INFO_DEPENDENCIES
  nrf5_bootloader_info
  nrf5_config
  nrf5_mdk
  nrf5_nrfx_common
  nrf5_nrfx_nvmc
  nrf5_soc
)

# Timers for DFU in the bootloader
add_library(nrf5_bootloader_dfu_timers OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/nrf_bootloader_dfu_timers.c"
)
target_include_directories(nrf5_bootloader_dfu_timers PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bootloader"
)
target_link_libraries(nrf5_bootloader_dfu_timers PUBLIC
  nrf5_delay
  nrf5_log
  nrf5_nrfx_hal
)
list(APPEND NRF5_LIBRARY_NRF5_BOOTLOADER_DFU_TIMERS_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_bootloader_dfu_timers
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

# Automated feeding of the watchdog
add_library(nrf5_bootloader_wdt OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/nrf_bootloader_wdt.c"
)
target_include_directories(nrf5_bootloader_wdt PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bootloader"
)
target_link_libraries(nrf5_bootloader_wdt PUBLIC
  nrf5_bootloader_dfu_timers
  nrf5_log
  nrf5_nrfx_hal
)
list(APPEND NRF5_LIBRARY_NRF5_BOOTLOADER_WDT_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_bootloader_dfu_timers
  nrf5_bootloader_wdt
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

# Firmware activation
add_library(nrf5_bootloader_fw_activation OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/nrf_bootloader_fw_activation.c"
)
target_include_directories(nrf5_bootloader_fw_activation PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bootloader"
)
target_link_libraries(nrf5_bootloader_fw_activation PUBLIC
  nrf5_bootloader_wdt
  nrf5_crc32
  nrf5_dfu_mbr
  nrf5_dfu_settings
  nrf5_dfu_utils
  nrf5_log
)
list(APPEND NRF5_LIBRARY_NRF5_BOOTLOADER_FW_ACTIVATION_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_bootloader_dfu_timers
  nrf5_bootloader_fw_activation
  nrf5_bootloader_wdt
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_crc32
  nrf5_delay
  nrf5_dfu_flash
  nrf5_dfu_mbr
  nrf5_dfu_settings
  nrf5_dfu_utils
  nrf5_ext_fprintf
  nrf5_ext_nanopb
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
  nrf5_nrfx_nvmc
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# Application start
add_library(nrf5_bootloader_app_start OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/nrf_bootloader_app_start.c"
  "${NRF5_SDK_PATH}/components/libraries/bootloader/nrf_bootloader_app_start_final.c"
)
target_include_directories(nrf5_bootloader_app_start PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bootloader"
)
target_link_libraries(nrf5_bootloader_app_start PUBLIC
  nrf5_bootloader_info
  nrf5_dfu_mbr
  nrf5_dfu_settings
  nrf5_dfu_utils
  nrf5_log
)
list(APPEND NRF5_LIBRARY_NRF5_BOOTLOADER_APP_START_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_bootloader_app_start
  nrf5_bootloader_info
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_crc32
  nrf5_delay
  nrf5_dfu_flash
  nrf5_dfu_mbr
  nrf5_dfu_settings
  nrf5_dfu_utils
  nrf5_ext_fprintf
  nrf5_ext_nanopb
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
  nrf5_nrfx_nvmc
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# Bootloader modules
add_library(nrf5_bootloader OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/bootloader/nrf_bootloader.c"
)
target_include_directories(nrf5_bootloader PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/bootloader"
)
target_link_libraries(nrf5_bootloader PUBLIC
  nrf5_app_scheduler
  nrf5_boards
  nrf5_bootloader_app_start
  nrf5_bootloader_fw_activation
  nrf5_dfu_validation
  nrf5_log
  nrf5_nrfx_hal
)
list(APPEND NRF5_LIBRARY_NRF5_BOOTLOADER_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_assert
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_boards
  nrf5_bootloader
  nrf5_bootloader_app_start
  nrf5_bootloader_dfu_timers
  nrf5_bootloader_fw_activation
  nrf5_bootloader_info
  nrf5_bootloader_wdt
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_crc32
  nrf5_crypto
  nrf5_delay
  nrf5_dfu_cc_pb
  nrf5_dfu_flash
  nrf5_dfu_mbr
  nrf5_dfu_settings
  nrf5_dfu_utils
  nrf5_dfu_validation
  nrf5_dfu_ver_validation
  nrf5_ext_cc310_bl_fwd
  nrf5_ext_cc310_fwd
  nrf5_ext_cifra_aes128_eax_fwd
  nrf5_ext_fprintf
  nrf5_ext_mbedtls_fwd
  nrf5_ext_micro_ecc_fwd
  nrf5_ext_nanopb
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
  nrf5_nrfx_nvmc
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_sha256_fwd
  nrf5_soc
  nrf5_stack_info
  nrf5_strerror
)
