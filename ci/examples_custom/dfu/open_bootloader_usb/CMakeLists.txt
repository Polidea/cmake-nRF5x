cmake_minimum_required(VERSION 3.14)
project(open_bootloader_usb LANGUAGES C ASM)

include("nrf5")

add_compile_definitions(
  CONFIG_GPIO_AS_PINRESET
  APP_TIMER_V2_RTC1_ENABLED
  NRF_DFU_SETTINGS_VERSION=2
  SVC_INTERFACE_CALL_AS_NORMAL_FUNCTION
)

add_executable(${CMAKE_PROJECT_NAME}
  "${NRF5_SDK_PATH}/examples/dfu/open_bootloader/main.c"
  "dfu_public_key.c"
)
nrf5_target(${CMAKE_PROJECT_NAME})
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
  # Common
  nrf5_mdk
  nrf5_section
  nrf5_strerror
  nrf5_atomic
  nrf5_atfifo
  nrf5_atflags
  nrf5_memobj
  nrf5_balloc
  nrf5_pwr_mgmt
  # Drivers
  nrf5_nrfx_soc
  nrf5_nrfx_clock
  nrf5_drv_clock
  nrf5_nrfx_systick
  nrf5_nrfx_power
  nrf5_drv_power
  nrf5_nrfx_nvmc
  nrf5_nrfx_usbd
  nrf5_drv_usbd
  # Application
  nrf5_app_util_platform
  nrf5_app_scheduler
  nrf5_app_timer_v2
  # Storage
  nrf5_fstorage
  nrf5_fstorage_nvmc  
  # Crypto
  nrf5_crypto
  nrf5_crypto_cc310_bl_backend
  # USB
  nrf5_app_usbd
  nrf5_app_usbd_serial_num
  nrf5_app_usbd_cdc_acm
  # DFU
  nrf5_dfu
  nrf5_dfu_cc_pb
  nrf5_dfu_flash
  nrf5_dfu_handling_error
  nrf5_dfu_mbr
  nrf5_dfu_req_handler
  nrf5_dfu_serial
  nrf5_dfu_serial_usb
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
  nrf5_ext_nanopb
  # Misc
  nrf5_led_softblink
  nrf5_low_power_pwm
  nrf5_crc32
  nrf5_slip
  nrf5_sortlist
)
