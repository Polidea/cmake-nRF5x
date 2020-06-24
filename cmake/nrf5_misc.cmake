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

# SD card library
add_library(nrf5_app_sdcard OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/sdcard/app_sdcard.c"
)
target_include_directories(nrf5_app_sdcard PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/sdcard"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_app_sdcard PUBLIC
  nrf5_drv_spi
  nrf5_ext_protothreads
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

# Low-power PWM
add_library(nrf5_low_power_pwm OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/low_power_pwm/low_power_pwm.c"
)
target_include_directories(nrf5_low_power_pwm PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/low_power_pwm"
)
target_link_libraries(nrf5_low_power_pwm PUBLIC
  nrf5_app_timer
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

# Serial port abstraction layer
add_library(nrf5_serial OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/serial/nrf_serial.c"
)
target_include_directories(nrf5_serial PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/serial"
)
target_link_libraries(nrf5_serial PUBLIC
  nrf5_app_timer
  nrf5_drv_uart
  nrf5_queue
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
