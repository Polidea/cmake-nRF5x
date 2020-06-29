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

# nrfx common
add_library(nrf5_nrfx_common INTERFACE)
target_include_directories(nrf5_nrfx_common INTERFACE
  "${NRF5_SDK_PATH}/integration/nrfx"
  "${NRF5_SDK_PATH}/modules/nrfx"
)
target_link_libraries(nrf5_nrfx_common INTERFACE
  nrf5_config
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_COMMON_DEPENDENCIES
  nrf5_config
  nrf5_nrfx_common
)

# nrfx SoC
add_library(nrf5_nrfx_soc OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/soc/nrfx_atomic.c"
)
target_include_directories(nrf5_nrfx_soc PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/soc"
)
target_link_libraries(nrf5_nrfx_soc PUBLIC
  nrf5_mdk
  nrf5_nrfx_common
  nrf5_soc
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_SOC_DEPENDENCIES
  nrf5_config
  nrf5_mdk
  nrf5_nrfx_common
  nrf5_nrfx_soc
  nrf5_soc
)

# nrfx Hardware Abstraction Layer (HAL)
add_library(nrf5_nrfx_hal INTERFACE)
target_include_directories(nrf5_nrfx_hal INTERFACE
  "${NRF5_SDK_PATH}/modules/nrfx/hal"
)
target_link_libraries(nrf5_nrfx_hal INTERFACE
  nrf5_nrfx_common
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_HAL_DEPENDENCIES
  nrf5_config
  nrf5_nrfx_common
  nrf5_nrfx_hal
)

# nrfx Peripheral Resource Sharing (PRS)
add_library(nrf5_nrfx_prs OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/prs/nrfx_prs.c"
)
target_include_directories(nrf5_nrfx_prs PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/prs"
)
target_link_libraries(nrf5_nrfx_prs PUBLIC
  nrf5_log
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_PRS_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_prs
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# CLOCK nrfx driver
add_library(nrf5_nrfx_clock OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_clock.c"
)
target_include_directories(nrf5_nrfx_clock PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_clock PUBLIC
  nrf5_log
  nrf5_nrfx_common
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_CLOCK_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_clock
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# CLOCK legacy driver
add_library(nrf5_drv_clock OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/integration/nrfx/legacy/nrf_drv_clock.c"
)
target_include_directories(nrf5_drv_clock PUBLIC
  "${NRF5_SDK_PATH}/integration/nrfx/legacy"
)
target_link_libraries(nrf5_drv_clock PUBLIC
  nrf5_nrfx_clock
)
list(APPEND NRF5_LIBRARY_NRF5_DRV_CLOCK_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_clock
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_clock
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# SysTick nrfx driver
add_library(nrf5_nrfx_systick OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_systick.c"
)
target_include_directories(nrf5_nrfx_systick PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_systick PUBLIC
  nrf5_log
  nrf5_nrfx_common
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_SYSTICK_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_systick
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# SysTick legacy driver
add_library(nrf5_drv_systick INTERFACE)
target_include_directories(nrf5_drv_systick INTERFACE
  "${NRF5_SDK_PATH}/integration/nrfx/legacy"
)
target_link_libraries(nrf5_drv_systick INTERFACE
  nrf5_nrfx_systick
)
list(APPEND NRF5_LIBRARY_NRF5_DRV_SYSTICK_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_systick
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_systick
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# POWER nrfx driver
add_library(nrf5_nrfx_power OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_power.c"
)
target_include_directories(nrf5_nrfx_power PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_power PUBLIC
  nrf5_log
  nrf5_nrfx_common
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_POWER_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_power
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# POWER legacy driver
add_library(nrf5_drv_power OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/integration/nrfx/legacy/nrf_drv_power.c"
)
target_include_directories(nrf5_drv_power PUBLIC
  "${NRF5_SDK_PATH}/integration/nrfx/legacy"
)
target_link_libraries(nrf5_drv_power PUBLIC
  nrf5_nrfx_power
)
list(APPEND NRF5_LIBRARY_NRF5_DRV_POWER_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_power
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_power
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# PPI nrfx driver
add_library(nrf5_nrfx_ppi OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_ppi.c"
)
target_include_directories(nrf5_nrfx_ppi PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_ppi PUBLIC
  nrf5_log
  nrf5_nrfx_common
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_PPI_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_ppi
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# PPI legacy driver
add_library(nrf5_drv_ppi OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/integration/nrfx/legacy/nrf_drv_ppi.c"
)
target_include_directories(nrf5_drv_ppi PUBLIC
  "${NRF5_SDK_PATH}/integration/nrfx/legacy"
)
target_link_libraries(nrf5_drv_ppi PUBLIC
  nrf5_nrfx_ppi
)
list(APPEND NRF5_LIBRARY_NRF5_DRV_PPI_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_ppi
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_ppi
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# GPIOTE nrfx driver
add_library(nrf5_nrfx_gpiote OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_gpiote.c"
)
target_include_directories(nrf5_nrfx_gpiote PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/integration/nrfx/legacy"
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_gpiote PUBLIC
  nrf5_log
  nrf5_nrfx_common
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_GPIOTE_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_gpiote
  nrf5_nrfx_hal
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# GPIOTE legacy driver
add_library(nrf5_drv_gpiote INTERFACE)
target_include_directories(nrf5_drv_gpiote INTERFACE
  "${NRF5_SDK_PATH}/integration/nrfx/legacy"
)
target_link_libraries(nrf5_drv_gpiote INTERFACE
  nrf5_nrfx_gpiote
)
list(APPEND NRF5_LIBRARY_NRF5_DRV_GPIOTE_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_gpiote
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_gpiote
  nrf5_nrfx_hal
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# UART (EasyDMA) nrfx driver
add_library(nrf5_nrfx_uarte OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_uarte.c"
)
target_include_directories(nrf5_nrfx_uarte PUBLIC
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_uarte PUBLIC
  nrf5_log
  nrf5_nrfx_common
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_UARTE_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_uarte
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# UART (no EasyDMA) nrfx driver
add_library(nrf5_nrfx_uart OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_uart.c"
)
target_include_directories(nrf5_nrfx_uart PUBLIC
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_uart PUBLIC
  nrf5_log
  nrf5_nrfx_common
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_UART_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_uart
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# UART legacy driver
add_library(nrf5_drv_uart OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/integration/nrfx/legacy/nrf_drv_uart.c"
)
target_include_directories(nrf5_drv_uart PUBLIC
  "${NRF5_SDK_PATH}/integration/nrfx/legacy"
)
target_link_libraries(nrf5_drv_uart PUBLIC
  nrf5_nrfx_uart
  nrf5_nrfx_uarte
)
list(APPEND NRF5_LIBRARY_NRF5_DRV_UART_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_uart
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_uart
  nrf5_nrfx_uarte
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# RNG driver
add_library(nrf5_nrfx_rng OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_rng.c"
)
target_include_directories(nrf5_nrfx_rng PUBLIC
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_rng PUBLIC
  nrf5_log
  nrf5_nrfx_common
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_RNG_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_rng
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# RNG legacy driver
add_library(nrf5_drv_rng OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/integration/nrfx/legacy/nrf_drv_rng.c"
)
target_include_directories(nrf5_drv_rng PUBLIC
  "${NRF5_SDK_PATH}/integration/nrfx/legacy"
)
target_link_libraries(nrf5_drv_rng PUBLIC
  nrf5_app_util_platform
  nrf5_nrfx_rng
  nrf5_soc
)
list(APPEND NRF5_LIBRARY_NRF5_DRV_RNG_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_rng
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_rng
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# TWI legacy driver
add_library(nrf5_drv_twi OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/integration/nrfx/legacy/nrf_drv_twi.c"
)
target_include_directories(nrf5_drv_twi PUBLIC
  "${NRF5_SDK_PATH}/integration/nrfx/legacy"
)
target_link_libraries(nrf5_drv_twi PUBLIC
  nrf5_nrfx_twi
)
list(APPEND NRF5_LIBRARY_NRF5_DRV_TWI_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_twi
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_twi
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# TWI driver
add_library(nrf5_nrfx_twi OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_twi.c"
)
target_include_directories(nrf5_nrfx_twi PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_twi PUBLIC
  nrf5_log
  nrf5_mdk
  nrf5_nrfx_common
  nrf5_soc
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_TWI_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_twi
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# TWIM nrfx driver
add_library(nrf5_nrfx_twim OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_twim.c"
)
target_include_directories(nrf5_nrfx_twim PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_twim PUBLIC
  nrf5_log
  nrf5_nrfx_common
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_TWIM_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_twim
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# RTC legacy driver (header only)
add_library(nrf5_drv_rtc INTERFACE)
target_include_directories(nrf5_drv_rtc INTERFACE
  "${NRF5_SDK_PATH}/integration/nrfx/legacy"
)
list(APPEND NRF5_LIBRARY_NRF5_DRV_RTC_DEPENDENCIES
  nrf5_drv_rtc
)

# TIMER driver
add_library(nrf5_nrfx_timer OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_timer.c"
)
target_include_directories(nrf5_nrfx_timer PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_timer PUBLIC
  nrf5_log
  nrf5_nrfx_common
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_TIMER_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_timer
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# TIMER legacy driver
add_library(nrf5_drv_timer INTERFACE)
target_include_directories(nrf5_drv_timer INTERFACE
  "${NRF5_SDK_PATH}/integration/nrfx/legacy"
)
target_link_libraries(nrf5_drv_timer INTERFACE
  nrf5_nrfx_timer
)
list(APPEND NRF5_LIBRARY_NRF5_DRV_TIMER_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_timer
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_timer
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# RTC driver
add_library(nrf5_nrfx_rtc OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_rtc.c"
)
target_include_directories(nrf5_nrfx_rtc PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_rtc PUBLIC
  nrf5_log
  nrf5_mdk
  nrf5_nrfx_common
  nrf5_soc
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_RTC_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_rtc
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# NRFX NVMC HAL library
add_library(nrf5_nrfx_nvmc OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/hal/nrf_nvmc.c"
)
target_include_directories(nrf5_nrfx_nvmc PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/hal"
)
target_link_libraries(nrf5_nrfx_nvmc PUBLIC
  nrf5_mdk
  nrf5_nrfx_common
  nrf5_soc
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_NVMC_DEPENDENCIES
  nrf5_config
  nrf5_mdk
  nrf5_nrfx_common
  nrf5_nrfx_nvmc
  nrf5_soc
)

# SPI nrfx driver
add_library(nrf5_nrfx_spi OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_spi.c"
)
target_include_directories(nrf5_nrfx_spi PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_spi PUBLIC
  nrf5_log
  nrf5_nrfx_common
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_SPI_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_spi
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# SPIM nrfx driver
add_library(nrf5_nrfx_spim OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_spim.c"
)
target_include_directories(nrf5_nrfx_spim PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_spim PUBLIC
  nrf5_log
  nrf5_nrfx_common
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_SPIM_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_spim
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# SPIS nrfx driver
add_library(nrf5_nrfx_spis OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_spis.c"
)
target_include_directories(nrf5_nrfx_spis PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_spis PUBLIC
  nrf5_log
  nrf5_nrfx_common
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_SPIS_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_spis
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# SPIM legacy driver
add_library(nrf5_drv_spi OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/integration/nrfx/legacy/nrf_drv_spi.c"
)
target_include_directories(nrf5_drv_spi PUBLIC
  "${NRF5_SDK_PATH}/integration/nrfx/legacy"
)
target_link_libraries(nrf5_drv_spi PUBLIC
  nrf5_nrfx_spi
  nrf5_nrfx_spim
)
list(APPEND NRF5_LIBRARY_NRF5_DRV_SPI_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_spi
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_spi
  nrf5_nrfx_spim
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# SPIS legacy driver
add_library(nrf5_drv_spis OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/integration/nrfx/legacy/nrf_drv_spis.c"
)
target_include_directories(nrf5_drv_spis PUBLIC
  "${NRF5_SDK_PATH}/integration/nrfx/legacy"
)
target_link_libraries(nrf5_drv_spis PUBLIC
  nrf5_nrfx_spis
)
list(APPEND NRF5_LIBRARY_NRF5_DRV_SPIS_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_spis
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_spis
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# QSPI nrfx driver
add_library(nrf5_nrfx_qspi OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_qspi.c"
)
target_include_directories(nrf5_nrfx_qspi PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_qspi PUBLIC
  nrf5_log
  nrf5_nrfx_common
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_QSPI_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_qspi
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# QSPI legacy driver
add_library(nrf5_drv_qspi INTERFACE)
target_include_directories(nrf5_drv_qspi INTERFACE
  "${NRF5_SDK_PATH}/integration/nrfx/legacy"
)
target_link_libraries(nrf5_drv_qspi INTERFACE
  nrf5_nrfx_qspi
)
list(APPEND NRF5_LIBRARY_NRF5_DRV_QSPI_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_qspi
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_qspi
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# USBD nrfx driver
add_library(nrf5_nrfx_usbd OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_usbd.c"
)
target_include_directories(nrf5_nrfx_usbd PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_usbd PUBLIC
  nrf5_log
  nrf5_nrfx_common
  nrf5_nrfx_soc
  nrf5_nrfx_systick
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_USBD_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_soc
  nrf5_nrfx_systick
  nrf5_nrfx_usbd
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# USBD legacy driver
add_library(nrf5_drv_usbd INTERFACE)
target_include_directories(nrf5_drv_usbd INTERFACE
  "${NRF5_SDK_PATH}/integration/nrfx/legacy"
)
target_link_libraries(nrf5_drv_usbd INTERFACE
  nrf5_nrfx_usbd
)
list(APPEND NRF5_LIBRARY_NRF5_DRV_USBD_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_usbd
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_soc
  nrf5_nrfx_systick
  nrf5_nrfx_usbd
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# I2S nrfx driver
add_library(nrf5_nrfx_i2s OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_i2s.c"
)
target_include_directories(nrf5_nrfx_i2s PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_i2s PUBLIC
  nrf5_log
  nrf5_nrfx_common
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_I2S_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_i2s
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# I2S legacy driver
add_library(nrf5_drv_i2s INTERFACE)
target_include_directories(nrf5_drv_i2s INTERFACE
  "${NRF5_SDK_PATH}/integration/nrfx/legacy"
)
target_link_libraries(nrf5_drv_i2s INTERFACE
  nrf5_nrfx_i2s
)
list(APPEND NRF5_LIBRARY_NRF5_DRV_I2S_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_i2s
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_i2s
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# COMP nrfx driver
add_library(nrf5_nrfx_comp OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_comp.c"
)
target_include_directories(nrf5_nrfx_comp PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_comp PUBLIC
  nrf5_log
  nrf5_nrfx_common
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_COMP_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_comp
  nrf5_nrfx_hal
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# COMP legacy driver
add_library(nrf5_drv_comp INTERFACE)
target_include_directories(nrf5_drv_comp INTERFACE
  "${NRF5_SDK_PATH}/integration/nrfx/legacy"
)
target_link_libraries(nrf5_drv_comp INTERFACE
  nrf5_nrfx_comp
)
list(APPEND NRF5_LIBRARY_NRF5_DRV_COMP_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_comp
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_comp
  nrf5_nrfx_hal
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# LPCOMP nrfx driver
add_library(nrf5_nrfx_lpcomp OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_lpcomp.c"
)
target_include_directories(nrf5_nrfx_lpcomp PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_lpcomp PUBLIC
  nrf5_log
  nrf5_nrfx_common
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_LPCOMP_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_lpcomp
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# LPCOMP legacy driver
add_library(nrf5_drv_lpcomp INTERFACE)
target_include_directories(nrf5_drv_lpcomp INTERFACE
  "${NRF5_SDK_PATH}/integration/nrfx/legacy"
)
target_link_libraries(nrf5_drv_lpcomp INTERFACE
  nrf5_nrfx_lpcomp
)
list(APPEND NRF5_LIBRARY_NRF5_DRV_LPCOMP_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_lpcomp
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_lpcomp
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# SAADC nrfx driver
add_library(nrf5_nrfx_saadc OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_saadc.c"
)
target_include_directories(nrf5_nrfx_saadc PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_saadc PUBLIC
  nrf5_log
  nrf5_nrfx_common
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_SAADC_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_saadc
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# SAADC legacy driver
add_library(nrf5_drv_saadc INTERFACE)
target_include_directories(nrf5_drv_saadc INTERFACE
  "${NRF5_SDK_PATH}/integration/nrfx/legacy"
)
target_link_libraries(nrf5_drv_saadc INTERFACE
  nrf5_nrfx_saadc
)
list(APPEND NRF5_LIBRARY_NRF5_DRV_SAADC_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_saadc
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_saadc
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# PWM nrfx driver
add_library(nrf5_nrfx_pwm OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_pwm.c"
)
target_include_directories(nrf5_nrfx_pwm PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_pwm PUBLIC
  nrf5_log
  nrf5_nrfx_common
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_PWM_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_pwm
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# PWM legacy driver
add_library(nrf5_drv_pwm INTERFACE)
target_include_directories(nrf5_drv_pwm INTERFACE
  "${NRF5_SDK_PATH}/integration/nrfx/legacy"
)
target_link_libraries(nrf5_drv_pwm INTERFACE
  nrf5_nrfx_pwm
)
list(APPEND NRF5_LIBRARY_NRF5_DRV_PWM_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_pwm
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_pwm
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# WDT nrfx driver
add_library(nrf5_nrfx_wdt OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_wdt.c"
)
target_include_directories(nrf5_nrfx_wdt PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_wdt PUBLIC
  nrf5_log
  nrf5_nrfx_common
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_WDT_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_wdt
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# WDT legacy driver
add_library(nrf5_drv_wdt INTERFACE)
target_include_directories(nrf5_drv_wdt INTERFACE
  "${NRF5_SDK_PATH}/integration/nrfx/legacy"
)
target_link_libraries(nrf5_drv_wdt INTERFACE
  nrf5_nrfx_wdt
)
list(APPEND NRF5_LIBRARY_NRF5_DRV_WDT_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_wdt
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_wdt
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# QDEC nrfx driver
add_library(nrf5_nrfx_qdec OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_qdec.c"
)
target_include_directories(nrf5_nrfx_qdec PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
)
target_link_libraries(nrf5_nrfx_qdec PUBLIC
  nrf5_log
  nrf5_nrfx_common
)
list(APPEND NRF5_LIBRARY_NRF5_NRFX_QDEC_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_qdec
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# QDEC legacy driver
add_library(nrf5_drv_qdec INTERFACE)
target_include_directories(nrf5_drv_qdec INTERFACE
  "${NRF5_SDK_PATH}/integration/nrfx/legacy"
)
target_link_libraries(nrf5_drv_qdec INTERFACE
  nrf5_nrfx_qdec
)
list(APPEND NRF5_LIBRARY_NRF5_DRV_QDEC_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_qdec
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_qdec
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)
