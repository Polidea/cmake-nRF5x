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

# File storage
add_library(nrf5_fstorage OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/fstorage/nrf_fstorage.c"
)
target_include_directories(nrf5_fstorage PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/fstorage"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_fstorage PUBLIC
  nrf5_config
  nrf5_log_fwd
  nrf5_section
  nrf5_soc
  nrf5_strerror
)
list(APPEND NRF5_LIBRARY_NRF5_FSTORAGE_DEPENDENCIES
  nrf5_config
  nrf5_fstorage
  nrf5_log_fwd
  nrf5_mdk
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# File storage (SoftDevice)
add_library(nrf5_fstorage_sd OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/fstorage/nrf_fstorage_sd.c"
)
target_link_libraries(nrf5_fstorage_sd PUBLIC
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_fstorage
  nrf5_sdh
  nrf5_section
)
list(APPEND NRF5_LIBRARY_NRF5_FSTORAGE_SD_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_config
  nrf5_fstorage
  nrf5_fstorage_sd
  nrf5_log_fwd
  nrf5_mdk
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# File storage (NVMC)
add_library(nrf5_fstorage_nvmc OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/fstorage/nrf_fstorage_nvmc.c"
)
target_link_libraries(nrf5_fstorage_nvmc PUBLIC
  nrf5_atomic
  nrf5_fstorage
  nrf5_nrfx_hal
  nrf5_nrfx_nvmc
)
list(APPEND NRF5_LIBRARY_NRF5_FSTORAGE_NVMC_DEPENDENCIES
  nrf5_atomic
  nrf5_config
  nrf5_fstorage
  nrf5_fstorage_nvmc
  nrf5_log_fwd
  nrf5_mdk
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_nrfx_nvmc
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# File data storage
add_library(nrf5_fds OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/fds/fds.c"
)
target_include_directories(nrf5_fds PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/fds"
)
target_link_libraries(nrf5_fds PUBLIC
  nrf5_atfifo
  nrf5_atomic
  nrf5_crc16
  nrf5_fstorage
)
list(APPEND NRF5_LIBRARY_NRF5_FDS_DEPENDENCIES
  nrf5_atfifo
  nrf5_atomic
  nrf5_config
  nrf5_crc16
  nrf5_fds
  nrf5_fstorage
  nrf5_log_fwd
  nrf5_mdk
  nrf5_section
  nrf5_soc
  nrf5_strerror
)
