cmake_minimum_required(VERSION 3.14)
project(cli LANGUAGES C ASM)

include("nrf5")

add_executable(${CMAKE_PROJECT_NAME}
  "${NRF5_SDK_PATH}/examples/peripheral/cli/main.c"
  "${NRF5_SDK_PATH}/examples/peripheral/cli/demo_cli_cmds.c"
)
nrf5_target(${CMAKE_PROJECT_NAME})
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
  # Common
  nrf5_mdk
  nrf5_section
  nrf5_strerror
  nrf5_atomic
  nrf5_atfifo
  nrf5_atflags
  nrf5_memobj
  nrf5_balloc
  nrf5_ringbuf
  nrf5_queue
  nrf5_pwr_mgmt
  # External
  nrf5_ext_fprintf
  nrf5_ext_segger_rtt
  nrf5_ext_fnmatch
  # Drivers
  nrf5_nrfx_prs
  nrf5_nrfx_clock
  nrf5_drv_clock
  nrf5_nrfx_nvmc
  nrf5_nrfx_uarte
  nrf5_nrfx_uart
  nrf5_drv_uart
  # Logger & CLI
  nrf5_log
  nrf5_log_backend_serial
  nrf5_log_backend_uart
  nrf5_log_backend_flash
  nrf5_log_default_backends
  nrf5_cli
  nrf5_cli_uart
  nrf5_cli_rtt
  # Application
  nrf5_app_error
  nrf5_app_util_platform
  nrf5_app_timer
  # Flash storage
  nrf5_fstorage
  nrf5_fstorage_nvmc
  nrf5_fds
  # BSP
  nrf5_boards
  nrf5_bsp
  # Misc
  nrf5_mpu
  nrf5_stack_guard
)

# Link additional libraries when building for nRF52840 (CLI over USB CDC ACM support)
if(NRF5_TARGET STREQUAL "nrf52840_xxaa")
  target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
    # Drivers
    nrf5_nrfx_soc
    nrf5_nrfx_systick
    nrf5_nrfx_power
    nrf5_drv_power  
    nrf5_nrfx_usbd
    nrf5_drv_usbd  
    # Logger & CLI
    nrf5_cli_cdc_acm
    # USB
    nrf5_app_usbd
    nrf5_app_usbd_core
    nrf5_app_usbd_serial_num
    nrf5_app_usbd_string_desc
    nrf5_app_usbd_cdc_acm
  )
endif()
