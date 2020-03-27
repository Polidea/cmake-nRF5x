cmake_minimum_required(VERSION 3.14)
project(nrf5_example LANGUAGES C CXX ASM)

list(APPEND CMAKE_MODULE_PATH "cmake")
include("nrf5")

add_executable(nrf5_example
  src/main.c)
target_link_libraries(nrf5_example PRIVATE nrf5_common)
