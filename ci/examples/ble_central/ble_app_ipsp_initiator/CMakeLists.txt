cmake_minimum_required(VERSION 3.14)
project(ble_app_ipsp_initiator LANGUAGES C ASM)

list(APPEND CMAKE_MODULE_PATH "../cmake")
include("nrf5")

add_executable(${CMAKE_PROJECT_NAME}
  "${NRF5_SDK_PATH}/examples/ble_central/ble_app_ipsp_initiator/main.c"
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
  nrf5_mem_manager
  nrf5_balloc
  nrf5_ringbuf
  nrf5_pwr_mgmt
  nrf5_fprintf
  # Drivers
  nrf5_nrfx_prs
  nrf5_nrfx_gpiote
  nrf5_nrfx_uarte
  nrf5_nrfx_uart
  nrf5_drv_uart
  # Logger
  nrf5_log
  nrf5_log_backend_serial
  nrf5_log_backend_uart
  nrf5_log_default_backends
  # Application
  nrf5_app_error
  nrf5_app_util_platform
  nrf5_app_timer
  nrf5_app_button
  # BSP
  nrf5_boards
  # BLE
  nrf5_sdh
  nrf5_ble_srv_ipsp
  # IoT
  nrf5_iot_common
)
