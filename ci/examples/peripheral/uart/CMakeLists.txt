cmake_minimum_required(VERSION 3.14)
project(uart LANGUAGES C ASM)

include("nrf5")

add_executable(${CMAKE_PROJECT_NAME}
  "${NRF5_SDK_PATH}/examples/peripheral/uart/main.c"
)

add_compile_definitions(
  BSP_DEFINES_ONLY
  CONFIG_GPIO_AS_PINRESET
)

nrf5_target(${CMAKE_PROJECT_NAME})
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
  # Drivers
  nrf5_nrfx_prs
  nrf5_nrfx_uarte
  nrf5_nrfx_uart
  nrf5_drv_uart
  # Application
  nrf5_app_error
  nrf5_app_util_platform
  nrf5_app_uart
  # BSP
  nrf5_boards
  nrf5_bsp_defs
)
