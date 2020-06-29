cmake_minimum_required(VERSION 3.14)
project(wdt LANGUAGES C ASM)

include("nrf5")

add_executable(${CMAKE_PROJECT_NAME}
  "${NRF5_SDK_PATH}/examples/peripheral/wdt/main.c"
)
nrf5_target(${CMAKE_PROJECT_NAME})
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
  # Drivers
  nrf5_nrfx_clock
  nrf5_drv_clock
  nrf5_nrfx_gpiote
  nrf5_nrfx_rtc
  nrf5_nrfx_wdt
  nrf5_drv_wdt
  # Application
  nrf5_app_error
  nrf5_app_util_platform
  nrf5_app_timer
  nrf5_app_button
  # BSP
  nrf5_boards
  nrf5_bsp
)
