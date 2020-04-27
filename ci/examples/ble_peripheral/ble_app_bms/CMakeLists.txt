cmake_minimum_required(VERSION 3.14)
project(ble_app_bms LANGUAGES C ASM)

list(APPEND CMAKE_MODULE_PATH "../cmake")
include("nrf5")

add_executable(${CMAKE_PROJECT_NAME}
  "${NRF5_SDK_PATH}/examples/ble_peripheral/ble_app_bms/main.c"
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
  # Flash storage
  nrf5_fstorage
  nrf5_fds
  # BSP
  nrf5_boards
  nrf5_bsp
  nrf5_bsp_btn_ble
  # BLE
  nrf5_sdh
  nrf5_ble_common
  nrf5_ble_advertising
  nrf5_ble_gatt
  nrf5_ble_qwr
  # Peer Manager
  nrf5_ble_pm_buffer
  nrf5_ble_peer_id
  nrf5_ble_security_dispatcher
  nrf5_ble_peer_database
  nrf5_ble_security_manager
  nrf5_ble_id_manager
  nrf5_ble_peer_data_storage
  nrf5_ble_gatt_cache_manager
  nrf5_ble_peer_manager_handler
  nrf5_ble_peer_manager
  # BLE services
  nrf5_ble_srv_dis
  nrf5_ble_srv_bms
)
