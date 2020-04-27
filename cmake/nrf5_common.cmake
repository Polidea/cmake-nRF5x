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

# This file MUST be included within nrf5.cmake file. Users should NOT include
# this file independently.

# Delay
add_library(nrf5_delay INTERFACE)
target_include_directories(nrf5_delay INTERFACE
  "${NRF5_SDK_PATH}/components/libraries/delay")

# strerror (error to string converion)
add_library(nrf5_strerror OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/strerror/nrf_strerror.c"
)
target_include_directories(nrf5_strerror PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/strerror"
)
target_link_libraries(nrf5_strerror PUBLIC nrf5_config nrf5_mdk nrf5_soc)

# Section variables (experimental)
add_library(nrf5_section OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/experimental_section_vars/nrf_section_iter.c"
)
target_include_directories(nrf5_section PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/experimental_section_vars"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_section nrf5_config nrf5_mdk nrf5_soc)

# Atomic
add_library(nrf5_atomic OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/atomic/nrf_atomic.c"
)
target_include_directories(nrf5_atomic PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/atomic"
)
target_link_libraries(nrf5_atomic PUBLIC nrf5_mdk nrf5_soc nrf5_config)

# fprintf
add_library(nrf5_fprintf OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/external/fprintf/nrf_fprintf.c"
  "${NRF5_SDK_PATH}/external/fprintf/nrf_fprintf_format.c"
)
target_include_directories(nrf5_fprintf PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/external/fprintf"
)
target_link_libraries(nrf5_fprintf PUBLIC nrf5_mdk nrf5_soc nrf5_config)

# Mutex
add_library(nrf5_mtx INTERFACE)
target_include_directories(nrf5_mtx INTERFACE
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/mutex"
)
target_link_libraries(nrf5_mtx INTERFACE nrf5_atomic)

# Logger forwarding interface (include directories only)
add_library(nrf5_log_fwd INTERFACE)
target_include_directories(nrf5_log_fwd INTERFACE
  "${NRF5_SDK_PATH}/components/libraries/log"
  "${NRF5_SDK_PATH}/components/libraries/log/src"
)

# SoftDevice Handler
add_library(nrf5_sdh OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/softdevice/common/nrf_sdh.c"
  "${NRF5_SDK_PATH}/components/softdevice/common/nrf_sdh_ble.c"
  "${NRF5_SDK_PATH}/components/softdevice/common/nrf_sdh_soc.c"
)
target_include_directories(nrf5_sdh PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/softdevice/common"
)
target_link_libraries(nrf5_sdh PUBLIC
  nrf5_section nrf5_strerror nrf5_log_fwd
)

# Block Allocator
add_library(nrf5_balloc OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/balloc/nrf_balloc.c"
)
target_include_directories(nrf5_balloc PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/balloc"
)
target_link_libraries(nrf5_balloc PUBLIC nrf5_section nrf5_log_fwd nrf5_soc nrf5_strerror)

# Memory Object
add_library(nrf5_memobj OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/memobj/nrf_memobj.c"
)
target_include_directories(nrf5_memobj PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/memobj"
)
target_link_libraries(nrf5_memobj PUBLIC nrf5_balloc nrf5_atomic)

# Ring Buffer
add_library(nrf5_ringbuf OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/ringbuf/nrf_ringbuf.c"
)
target_include_directories(nrf5_ringbuf PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/ringbuf"
)
target_link_libraries(nrf5_ringbuf PUBLIC nrf5_atomic)

# Atomic FIFO
add_library(nrf5_atfifo OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/atomic_fifo/nrf_atfifo.c"
)
target_include_directories(nrf5_atfifo PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/atomic_fifo"
)
target_link_libraries(nrf5_atfifo PUBLIC nrf5_section nrf5_log_fwd nrf5_strerror)

# Atomic Flags
add_library(nrf5_atflags OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/atomic_flags/nrf_atflags.c"
)
target_include_directories(nrf5_atflags PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/atomic_flags"
)
target_link_libraries(nrf5_atflags PUBLIC nrf5_atomic)

# Queue
add_library(nrf5_queue OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/queue/nrf_queue.c"
)
target_include_directories(nrf5_queue PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/queue"
)
target_link_libraries(nrf5_queue PUBLIC nrf5_section nrf5_log_fwd nrf5_strerror)

# Power management
add_library(nrf5_pwr_mgmt OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/pwr_mgmt/nrf_pwr_mgmt.c"
)
target_include_directories(nrf5_pwr_mgmt PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/pwr_mgmt"
)
target_link_libraries(nrf5_pwr_mgmt PUBLIC
  nrf5_mtx
  nrf5_section
  nrf5_nrfx_hal
  nrf5_log_fwd
  nrf5_memobj
  nrf5_sdh
)

# Stack Info
add_library(nrf5_stack_info INTERFACE)
target_include_directories(nrf5_stack_info INTERFACE
  "${NRF5_SDK_PATH}/components/libraries/stack_info"
)

# SVC
add_library(nrf5_svc OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/svc/nrf_svc_handler.c"
)
target_include_directories(nrf5_svc PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/svc"
)
target_link_libraries(nrf5_svc PUBLIC nrf5_section)
