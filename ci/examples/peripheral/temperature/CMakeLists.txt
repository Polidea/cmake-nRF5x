cmake_minimum_required(VERSION 3.14)
project(temperature LANGUAGES C ASM)

include("nrf5")

add_executable(${CMAKE_PROJECT_NAME}
  "${NRF5_SDK_PATH}/examples/peripheral/temperature/main.c"
)
# This example requires only definitions from bsp.h file. Missing configuration
# in sdk_config.h won't allow to compile bsp.c.
target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE
  "${NRF5_SDK_PATH}/components/libraries/bsp"
)

add_definitions(-DBSP_DEFINES_ONLY -DCONFIG_GPIO_AS_PINRESET)

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
  # BSP
  nrf5_boards
)
