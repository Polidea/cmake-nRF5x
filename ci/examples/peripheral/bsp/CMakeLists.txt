cmake_minimum_required(VERSION 3.14)
project(bsp LANGUAGES C ASM)

include("nrf5")

add_executable(${CMAKE_PROJECT_NAME}
  "${NRF5_SDK_PATH}/examples/peripheral/bsp/main.c"
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
  # Drivers
  nrf5_nrfx_prs
  nrf5_nrfx_gpiote
  nrf5_nrfx_uarte
  nrf5_nrfx_uart
  nrf5_drv_uart
  # External
  nrf5_ext_fprintf
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
)
