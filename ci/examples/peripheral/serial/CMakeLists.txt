cmake_minimum_required(VERSION 3.14)
project(serial LANGUAGES C ASM)

include("nrf5")

add_executable(${CMAKE_PROJECT_NAME}
  "${NRF5_SDK_PATH}/examples/peripheral/serial/main.c"
)
nrf5_target(${CMAKE_PROJECT_NAME})
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
  # Common
  nrf5_section
  nrf5_strerror
  nrf5_atomic
  nrf5_memobj
  nrf5_balloc
  nrf5_ringbuf
  nrf5_queue
  # Drivers
  nrf5_nrfx_prs
  nrf5_nrfx_clock
  nrf5_drv_clock
  nrf5_nrfx_power
  nrf5_drv_power
  nrf5_nrfx_uarte
  nrf5_nrfx_uart
  nrf5_drv_uart
  # External
  nrf5_ext_fprintf
  # Logger
  nrf5_log
  nrf5_log_backend_serial
  nrf5_log_backend_uart
  # Application
  nrf5_app_error
  nrf5_app_util_platform
  nrf5_app_timer
  # BSP
  nrf5_boards
  # Misc
  nrf5_serial
)
