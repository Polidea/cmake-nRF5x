cmake_minimum_required(VERSION 3.14)
project(ble_app_uart LANGUAGES C ASM)

list(APPEND CMAKE_MODULE_PATH "../cmake")
include("nrf5")

add_executable(${CMAKE_PROJECT_NAME}
  "${NRF5_SDK_PATH}/examples/ble_peripheral/ble_app_uart/main.c"
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
  nrf5_ringbuf
  nrf5_pwr_mgmt
  # External
  nrf5_ext_fprintf
  # Drivers
  nrf5_nrfx_prs
  nrf5_nrfx_gpiote
  nrf5_nrfx_uarte
  nrf5_nrfx_uart
  nrf5_drv_uart
  # External
  nrf5_ext_segger_rtt
  # Logger
  nrf5_log
  nrf5_log_backend_serial
  nrf5_log_backend_rtt
  nrf5_log_default_backends
  # Application
  nrf5_app_error
  nrf5_app_util_platform
  nrf5_app_timer
  nrf5_app_button
  nrf5_app_uart
  # BSP
  nrf5_boards
  nrf5_bsp
  nrf5_bsp_btn_ble
  # BLE
  nrf5_sdh
  nrf5_ble_common
  nrf5_ble_link_ctx_manager
  nrf5_ble_advertising
  nrf5_ble_gatt
  nrf5_ble_qwr
  nrf5_ble_srv_nus
)
