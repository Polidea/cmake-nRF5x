cmake_minimum_required(VERSION 3.14)
project(rtc LANGUAGES C ASM)

include("nrf5")

add_executable(${CMAKE_PROJECT_NAME}
  "${NRF5_SDK_PATH}/examples/peripheral/rtc/main.c"
)
nrf5_target(${CMAKE_PROJECT_NAME})
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
  # Drivers
  nrf5_nrfx_prs
  nrf5_nrfx_clock
  nrf5_drv_clock
  nrf5_nrfx_rtc
  # Application
  nrf5_app_error
  nrf5_app_util_platform
  # BSP
  nrf5_boards
)
