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

# Block device
add_library(nrf5_block_dev INTERFACE)
target_include_directories(nrf5_block_dev INTERFACE
  "${NRF5_SDK_PATH}/components/libraries/block_dev"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_block_dev INTERFACE
  nrf5_config
)
list(APPEND NRF5_LIBRARY_NRF5_BLOCK_DEV_DEPENDENCIES
  nrf5_block_dev
  nrf5_config
)

# Block device empty implementation
add_library(nrf5_block_dev_empty OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/block_dev/empty/nrf_block_dev_empty.c"
)
target_include_directories(nrf5_block_dev_empty PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/block_dev/empty"
)
target_link_libraries(nrf5_block_dev_empty PUBLIC
  nrf5_block_dev
  nrf5_log
)
list(APPEND NRF5_LIBRARY_NRF5_BLOCK_DEV_EMPTY_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_block_dev
  nrf5_block_dev_empty
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
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# Block device QSPI implementation
add_library(nrf5_block_dev_qspi OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/block_dev/qspi/nrf_block_dev_qspi.c"
  "${NRF5_SDK_PATH}/components/libraries/block_dev/qspi/nrf_serial_flash_params.c"
)
target_include_directories(nrf5_block_dev_qspi PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/block_dev/qspi"
)
target_link_libraries(nrf5_block_dev_qspi PUBLIC
  nrf5_block_dev
  nrf5_drv_qspi
)
list(APPEND NRF5_LIBRARY_NRF5_BLOCK_DEV_QSPI_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_block_dev
  nrf5_block_dev_qspi
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

# Block device RAM implementation
add_library(nrf5_block_dev_ram OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/block_dev/ram/nrf_block_dev_ram.c"
)
target_include_directories(nrf5_block_dev_ram PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/block_dev/ram"
)
target_link_libraries(nrf5_block_dev_ram PUBLIC
  nrf5_block_dev
  nrf5_log
)
list(APPEND NRF5_LIBRARY_NRF5_BLOCK_DEV_RAM_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_block_dev
  nrf5_block_dev_ram
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
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# Block device SDC implementation
add_library(nrf5_block_dev_sdc OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/block_dev/sdc/nrf_block_dev_sdc.c"
)
target_include_directories(nrf5_block_dev_sdc PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/block_dev/sdc"
)
target_link_libraries(nrf5_block_dev_sdc PUBLIC
  nrf5_app_sdcard
  nrf5_block_dev
)
list(APPEND NRF5_LIBRARY_NRF5_BLOCK_DEV_SDC_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_sdcard
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_block_dev
  nrf5_block_dev_sdc
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_spi
  nrf5_ext_fprintf
  nrf5_ext_protothreads
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

# Low-power PWM
add_library(nrf5_low_power_pwm OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/low_power_pwm/low_power_pwm.c"
)
target_include_directories(nrf5_low_power_pwm PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/low_power_pwm"
)
target_link_libraries(nrf5_low_power_pwm PUBLIC
  nrf5_app_timer_fwd
)
list(APPEND NRF5_LIBRARY_NRF5_LOW_POWER_PWM_DEPENDENCIES
  nrf5_app_error
  nrf5_app_scheduler
  nrf5_app_timer_fwd
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
  nrf5_low_power_pwm
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
  nrf5_sortlist
  nrf5_strerror
)

# LED softblink
add_library(nrf5_led_softblink OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/led_softblink/led_softblink.c"
)
target_include_directories(nrf5_led_softblink PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/led_softblink"
)
target_link_libraries(nrf5_led_softblink PUBLIC
  nrf5_low_power_pwm
)
list(APPEND NRF5_LIBRARY_NRF5_LED_SOFTBLINK_DEPENDENCIES
  nrf5_app_error
  nrf5_app_scheduler
  nrf5_app_timer_fwd
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
  nrf5_led_softblink
  nrf5_log
  nrf5_log_fwd
  nrf5_low_power_pwm
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
  nrf5_sortlist
  nrf5_strerror
)

# Serial port abstraction layer
add_library(nrf5_serial OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/serial/nrf_serial.c"
)
target_include_directories(nrf5_serial PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/serial"
)
target_link_libraries(nrf5_serial PUBLIC
  nrf5_app_timer_fwd
  nrf5_drv_uart
  nrf5_queue
)
list(APPEND NRF5_LIBRARY_NRF5_SERIAL_DEPENDENCIES
  nrf5_app_error
  nrf5_app_scheduler
  nrf5_app_timer_fwd
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
  nrf5_nrfx_prs
  nrf5_nrfx_uart
  nrf5_nrfx_uarte
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_serial
  nrf5_soc
  nrf5_sortlist
  nrf5_strerror
)

# CRC16 compute
add_library(nrf5_crc16 OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/crc16/crc16.c"
)
target_include_directories(nrf5_crc16 PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/crc16"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_crc16 PUBLIC
  nrf5_config
  nrf5_mdk
  nrf5_soc
)
list(APPEND NRF5_LIBRARY_NRF5_CRC16_DEPENDENCIES
  nrf5_config
  nrf5_crc16
  nrf5_mdk
  nrf5_soc
)

# CRC32 compute
add_library(nrf5_crc32 OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/crc32/crc32.c"
)
target_include_directories(nrf5_crc32 PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/crc32"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_crc32 PUBLIC
  nrf5_config
  nrf5_mdk
  nrf5_soc
)
list(APPEND NRF5_LIBRARY_NRF5_CRC32_DEPENDENCIES
  nrf5_config
  nrf5_crc32
  nrf5_mdk
  nrf5_soc
)

# SLIP encoding and decoding
add_library(nrf5_slip OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/slip/slip.c"
)
target_include_directories(nrf5_slip PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/slip"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_slip PUBLIC
  nrf5_config
  nrf5_mdk
  nrf5_soc
)
list(APPEND NRF5_LIBRARY_NRF5_SLIP_DEPENDENCIES
  nrf5_config
  nrf5_mdk
  nrf5_slip
  nrf5_soc
)
