cmake_minimum_required(VERSION 3.14)
project(timer LANGUAGES C ASM)

include("nrf5")

add_executable(${CMAKE_PROJECT_NAME}
  "${NRF5_SDK_PATH}/examples/peripheral/timer/main.c"
)

add_compile_definitions(
  BSP_DEFINES_ONLY
  CONFIG_GPIO_AS_PINRESET
)

nrf5_target(${CMAKE_PROJECT_NAME})
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
  nrf5_boards
  nrf5_bsp_defs
  nrf5_nrfx_timer
  nrf5_drv_timer
  nrf5_app_error
)
