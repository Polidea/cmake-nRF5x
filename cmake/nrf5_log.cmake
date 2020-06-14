# MIT License

# Copyright (c) 2020 Polidea

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# WARNING: FILE GENERATED FROM ./ci/scripts/generate_cmake.sh SCRIPT.

# Command Line Interface (CLI)
add_library(nrf5_cli OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/cli/nrf_cli.c"
)
target_include_directories(nrf5_cli PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/cli"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_cli PUBLIC
  nrf5_atomic
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_log_fwd
  nrf5_memobj
  nrf5_nrfx_common
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_section
)

# UART command line interface transport layer
add_library(nrf5_cli_uart OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/cli/uart/nrf_cli_uart.c"
)
target_include_directories(nrf5_cli_uart PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/cli/uart"
)
target_link_libraries(nrf5_cli_uart PUBLIC
  nrf5_app_timer
  nrf5_cli
  nrf5_drv_uart
)

# RTT command line interface transport layer
add_library(nrf5_cli_rtt OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/cli/rtt/nrf_cli_rtt.c"
)
target_include_directories(nrf5_cli_rtt PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/cli/rtt"
)
target_link_libraries(nrf5_cli_rtt PUBLIC
  nrf5_app_timer
  nrf5_cli
  nrf5_ext_segger_rtt
)

# Logger (frontend & formatter)
add_library(nrf5_log OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/log/src/nrf_log_frontend.c"
  "${NRF5_SDK_PATH}/components/libraries/log/src/nrf_log_str_formatter.c"
)
target_include_directories(nrf5_log PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/log"
  "${NRF5_SDK_PATH}/components/libraries/log/src"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_log PUBLIC
  nrf5_cli
  nrf5_config
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_mdk
  nrf5_memobj
  nrf5_ringbuf
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# Logger Serial backend
add_library(nrf5_log_backend_serial OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/log/src/nrf_log_backend_serial.c"
)
target_link_libraries(nrf5_log_backend_serial PUBLIC
  nrf5_log
)

# Logger UART backend
add_library(nrf5_log_backend_uart OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/log/src/nrf_log_backend_uart.c"
)
target_link_libraries(nrf5_log_backend_uart PUBLIC
  nrf5_drv_uart
  nrf5_log
)

# Logger Flash backend
add_library(nrf5_log_backend_flash OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/log/src/nrf_log_backend_flash.c"
)
target_link_libraries(nrf5_log_backend_flash PUBLIC
  nrf5_fstorage
  nrf5_fstorage_nvmc
  nrf5_log
)

# Logger RTT backend
add_library(nrf5_log_backend_rtt OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/log/src/nrf_log_backend_rtt.c"
)
target_link_libraries(nrf5_log_backend_rtt PUBLIC
  nrf5_ext_segger_rtt
  nrf5_log
)

# Logger (default backends)
add_library(nrf5_log_default_backends OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/log/src/nrf_log_default_backends.c"
)
target_link_libraries(nrf5_log_default_backends PUBLIC
  nrf5_log
)
