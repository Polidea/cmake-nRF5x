cmake_minimum_required(VERSION 3.14)
project(simple_timer LANGUAGES C ASM)

include("nrf5")

add_executable(${CMAKE_PROJECT_NAME}
  "${NRF5_SDK_PATH}/examples/peripheral/simple_timer/main.c"
)
nrf5_target(${CMAKE_PROJECT_NAME})
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
  nrf5_nrfx_timer
  nrf5_app_error
  nrf5_app_util_platform
  nrf5_app_simple_timer
  nrf5_boards
)
