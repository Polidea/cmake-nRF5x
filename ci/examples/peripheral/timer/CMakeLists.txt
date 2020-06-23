cmake_minimum_required(VERSION 3.14)
project(timer LANGUAGES C ASM)

include("nrf5")

add_executable(${CMAKE_PROJECT_NAME}
  "${NRF5_SDK_PATH}/examples/peripheral/timer/main.c"
)
# This example requires only definitions from bsp.h file. Missing configuration
# in sdk_config.h won't allow to compile bsp.c.
target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE
  "${NRF5_SDK_PATH}/components/libraries/bsp"
)

add_definitions(-DBSP_DEFINES_ONLY -DCONFIG_GPIO_AS_PINRESET)

nrf5_target(${CMAKE_PROJECT_NAME})
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
  nrf5_boards
  nrf5_nrfx_timer
  nrf5_drv_timer
  nrf5_app_error
)
