cmake_minimum_required(VERSION 3.14)
project(led_softblink LANGUAGES C ASM)

include("nrf5")

add_executable(${CMAKE_PROJECT_NAME}
  "${NRF5_SDK_PATH}/examples/peripheral/led_softblink/main.c"
)
nrf5_target(${CMAKE_PROJECT_NAME})
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
  # Drivers
  nrf5_nrfx_ppi
  nrf5_drv_ppi
  nrf5_nrfx_clock
  nrf5_drv_clock
  nrf5_nrfx_gpiote
  nrf5_nrfx_timer
  # Application
  nrf5_app_error
  nrf5_app_util_platform
  nrf5_app_timer
  # BSP
  nrf5_boards
  # Misc
  nrf5_low_power_pwm
  nrf5_led_softblink
)
