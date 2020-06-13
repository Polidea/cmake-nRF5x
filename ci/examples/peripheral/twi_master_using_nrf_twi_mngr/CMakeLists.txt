cmake_minimum_required(VERSION 3.14)
project(twi_master_using_nrf_twi_mngr LANGUAGES C ASM)

include("nrf5")

add_executable(${CMAKE_PROJECT_NAME}
  "${NRF5_SDK_PATH}/examples/peripheral/twi_master_using_nrf_twi_mngr/main.c"
  "${NRF5_SDK_PATH}/examples/peripheral/twi_master_using_nrf_twi_mngr/lm75b.c"
  "${NRF5_SDK_PATH}/examples/peripheral/twi_master_using_nrf_twi_mngr/mma7660.c"
)
target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE
  "${NRF5_SDK_PATH}/examples/peripheral/twi_master_using_nrf_twi_mngr"
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
  nrf5_queue
  nrf5_pwr_mgmt
  # External
  nrf5_ext_fprintf
  # Drivers
  nrf5_nrfx_prs
  nrf5_nrfx_clock
  nrf5_drv_clock
  nrf5_nrfx_gpiote
  nrf5_nrfx_uarte
  nrf5_nrfx_uart
  nrf5_drv_uart
  nrf5_nrfx_twi
  nrf5_drv_twi
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
  nrf5_bsp
  # Miscellaneous
  nrf5_twi_mngr
)
