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
