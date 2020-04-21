cmake_minimum_required(VERSION 3.14)
project(ble_app_pwr_profiling LANGUAGES C ASM)

list(APPEND CMAKE_MODULE_PATH "../cmake")
include("nrf5")

add_executable(${CMAKE_PROJECT_NAME} main.c)
nrf5_target(${CMAKE_PROJECT_NAME})
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
  # Common
  nrf5_section
  nrf5_strerror
  nrf5_atomic
  nrf5_atflags
  nrf5_pwr_mgmt
  # Drivers
  nrf5_nrfx_prs
  nrf5_nrfx_gpiote
  # Application
  nrf5_app_error
  nrf5_app_util_platform
  nrf5_app_timer
  nrf5_app_button
  # BSP
  nrf5_boards
  nrf5_bsp
  # BLE
  nrf5_softdevice_handler
  nrf5_ble_common
  nrf5_ble_gatt
  nrf5_ble_qwr
)
