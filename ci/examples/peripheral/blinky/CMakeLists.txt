cmake_minimum_required(VERSION 3.14)
project(ble_app_blinky LANGUAGES C ASM)

include("nrf5")

add_executable(${CMAKE_PROJECT_NAME} main.c)
nrf5_target(${CMAKE_PROJECT_NAME})
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
  # BSP
  nrf5_boards
  nrf5_bsp
)
