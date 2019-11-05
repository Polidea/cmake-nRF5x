cmake_minimum_required(VERSION 3.12)

set(NRF_TARGET nrf52)

include("../../nrf-toolchain.cmake")
include("../../CMake_nRF5x.cmake")

nRF5x_toolchainSetup()

project(ExampleProject C)

add_subdirectory(src)
