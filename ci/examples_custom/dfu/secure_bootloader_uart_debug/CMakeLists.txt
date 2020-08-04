cmake_minimum_required(VERSION 3.14)
project(secure_bootloader_uart_debug LANGUAGES C ASM)

include("nrf5")

include_directories("${NRF5_SDK_PATH}/examples/dfu/secure_bootloader")
add_compile_definitions(
  DEBUG_NRF
  CONFIG_GPIO_AS_PINRESET
  MBR_PRESENT
  NRF_DFU_DEBUG_VERSION
  NRF_DFU_SETTINGS_VERSION=2
  SVC_INTERFACE_CALL_AS_NORMAL_FUNCTION
)

add_executable(${CMAKE_PROJECT_NAME}
  "${NRF5_SDK_PATH}/examples/dfu/secure_bootloader/main.c"
  "${NRF5_SDK_PATH}/examples/dfu/dfu_public_key.c"
)
nrf5_target(${CMAKE_PROJECT_NAME})
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
  # Common
  nrf5_mdk
  nrf5_section
  nrf5_strerror
  nrf5_atomic
  nrf5_atflags
  nrf5_memobj
  nrf5_balloc
  nrf5_ringbuf
  nrf5_queue
  nrf5_assert
  nrf5_sha256
  # Drivers
  nrf5_nrfx_prs
  nrf5_nrfx_uarte
  nrf5_nrfx_uart
  nrf5_drv_uart
  nrf5_nrfx_nvmc
  # Logger
  nrf5_log
  nrf5_log_backend_serial
  nrf5_log_backend_rtt
  nrf5_log_default_backends
  # Application
  nrf5_app_util_platform
  nrf5_app_scheduler
  # Storage
  nrf5_fstorage
  nrf5_fstorage_nvmc
  # Crypto
  nrf5_crypto
  # DFU
  nrf5_dfu
  nrf5_dfu_cc_pb
  nrf5_dfu_flash
  nrf5_dfu_handling_error
  nrf5_dfu_mbr
  nrf5_dfu_req_handler
  nrf5_dfu_serial
  nrf5_dfu_serial_uart
  nrf5_dfu_settings
  nrf5_dfu_transport
  nrf5_dfu_utils
  nrf5_dfu_validation
  nrf5_dfu_ver_validation
  # Bootloader
  nrf5_bootloader
  nrf5_bootloader_app_start
  nrf5_bootloader_dfu_timers
  nrf5_bootloader_fw_activation
  nrf5_bootloader_info
  nrf5_bootloader_wdt
  # BSP
  nrf5_boards
  # External
  nrf5_ext_fprintf
  nrf5_ext_nanopb
  nrf5_ext_segger_rtt
  # Misc
  nrf5_crc32
  nrf5_slip
)

if(NRF5_BOARD_DEFINE STREQUAL "BOARD_PCA10040")
  add_compile_definitions(
    ECC_ENABLE_VLI_API=0
    ECC_OPTIMIZATION_LEVEL=3
    ECC_SQUARE_FUNC=0
    ECC_SUPPORT_COMPRESSED_POINT=0
    ECC_VLI_NATIVE_LITTLE_ENDIAN=1
  )
  target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
    nrf5_crypto_micro_ecc_backend
    nrf5_crypto_nrf_sw_backend
    micro_ecc
  )
elseif(NRF5_BOARD_DEFINE STREQUAL "BOARD_PCA10056" AND NRF5_TARGET STREQUAL "nrf52840_xxaa")
  target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
    nrf5_crypto_cc310_bl_backend
  ) 
endif()
