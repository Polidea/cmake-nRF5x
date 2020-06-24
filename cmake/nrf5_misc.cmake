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

# Sensor Data Simulator
add_library(nrf5_sensorsim OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/sensorsim/sensorsim.c"
)
target_include_directories(nrf5_sensorsim PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/sensorsim"
)
list(APPEND NRF5_LIBRARY_NRF5_SENSORSIM_DEPENDENCIES
  nrf5_sensorsim
)

# GFX Library
add_library(nrf5_gfx OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/gfx/nrf_gfx.c"
)
target_include_directories(nrf5_gfx PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/gfx"
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/external/thedotfactory_fonts"
)
target_link_libraries(nrf5_gfx PUBLIC
  nrf5_app_util_platform
  nrf5_log
  nrf5_nrfx_common
)
list(APPEND NRF5_LIBRARY_NRF5_GFX_DEPENDENCIES
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_gfx
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
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

# SPI transaction manager
add_library(nrf5_spi_mngr OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/spi_mngr/nrf_spi_mngr.c"
)
target_include_directories(nrf5_spi_mngr PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/spi_mngr"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_spi_mngr PUBLIC
  nrf5_app_util_platform
  nrf5_drv_spi
  nrf5_queue
)
list(APPEND NRF5_LIBRARY_NRF5_SPI_MNGR_DEPENDENCIES
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
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
  nrf5_spi_mngr
  nrf5_strerror
)

# TWI transaction manager
add_library(nrf5_twi_mngr OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/twi_mngr/nrf_twi_mngr.c"
)
target_include_directories(nrf5_twi_mngr PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/twi_mngr"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_twi_mngr PUBLIC
  nrf5_app_util_platform
  nrf5_drv_twi
  nrf5_queue
)
list(APPEND NRF5_LIBRARY_NRF5_TWI_MNGR_DEPENDENCIES
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
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
  nrf5_twi_mngr
)

# MPU (Memory Protection Unit) driver
add_library(nrf5_mpu OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/mpu/nrf_mpu_lib.c"
)
target_include_directories(nrf5_mpu PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/mpu"
)
target_link_libraries(nrf5_mpu PUBLIC
  nrf5_cli
  nrf5_log
)
list(APPEND NRF5_LIBRARY_NRF5_MPU_DEPENDENCIES
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mpu
  nrf5_mtx
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

# Stack guard
add_library(nrf5_stack_guard OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/stack_guard/nrf_stack_guard.c"
)
target_include_directories(nrf5_stack_guard PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/stack_guard"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_stack_guard PUBLIC
  nrf5_mpu
)
list(APPEND NRF5_LIBRARY_NRF5_STACK_GUARD_DEPENDENCIES
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_delay
  nrf5_ext_fprintf
  nrf5_fds
  nrf5_fstorage
  nrf5_log
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mpu
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_stack_guard
  nrf5_strerror
)

# Block device library (API layer)
add_library(nrf5_block_dev INTERFACE)
target_include_directories(nrf5_block_dev INTERFACE
  "${NRF5_SDK_PATH}/components/libraries/block_dev"
)
list(APPEND NRF5_LIBRARY_NRF5_BLOCK_DEV_DEPENDENCIES
  nrf5_block_dev
)
