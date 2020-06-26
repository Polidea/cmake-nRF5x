cmake_minimum_required(VERSION 3.14)
project(pin_change_int LANGUAGES C ASM)

include("nrf5")

add_executable(${CMAKE_PROJECT_NAME}
  "${NRF5_SDK_PATH}/examples/peripheral/pin_change_int/main.c"
)
nrf5_target(${CMAKE_PROJECT_NAME})
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
  # Drivers
  nrf5_nrfx_prs
  nrf5_nrfx_gpiote
  # Application
  nrf5_app_error
  # BSP
  nrf5_boards
)
