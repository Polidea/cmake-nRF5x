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

# Delay
add_library(nrf5_delay INTERFACE)
target_include_directories(nrf5_delay INTERFACE
  "${NRF5_SDK_PATH}/components/libraries/delay"
)
list(APPEND NRF5_LIBRARY_NRF5_DELAY_DEPENDENCIES
  nrf5_delay
)

# strerror (error to string converion)
add_library(nrf5_strerror OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/strerror/nrf_strerror.c"
)
target_include_directories(nrf5_strerror PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/strerror"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_strerror PUBLIC
  nrf5_config
  nrf5_mdk
  nrf5_soc
)
list(APPEND NRF5_LIBRARY_NRF5_STRERROR_DEPENDENCIES
  nrf5_config
  nrf5_mdk
  nrf5_soc
  nrf5_strerror
)

# Section variables (experimental)
add_library(nrf5_section OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/experimental_section_vars/nrf_section_iter.c"
)
target_include_directories(nrf5_section PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/experimental_section_vars"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_section PUBLIC
  nrf5_config
  nrf5_mdk
  nrf5_soc
)
list(APPEND NRF5_LIBRARY_NRF5_SECTION_DEPENDENCIES
  nrf5_config
  nrf5_mdk
  nrf5_section
  nrf5_soc
)

# Atomic
add_library(nrf5_atomic OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/atomic/nrf_atomic.c"
)
target_include_directories(nrf5_atomic PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/atomic"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_atomic PUBLIC
  nrf5_config
  nrf5_mdk
  nrf5_soc
)
list(APPEND NRF5_LIBRARY_NRF5_ATOMIC_DEPENDENCIES
  nrf5_atomic
  nrf5_config
  nrf5_mdk
  nrf5_soc
)

# Mutex
add_library(nrf5_mtx INTERFACE)
target_include_directories(nrf5_mtx INTERFACE
  "${NRF5_SDK_PATH}/components/libraries/mutex"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_mtx INTERFACE
  nrf5_atomic
)
list(APPEND NRF5_LIBRARY_NRF5_MTX_DEPENDENCIES
  nrf5_atomic
  nrf5_config
  nrf5_mdk
  nrf5_mtx
  nrf5_soc
)

# Logger forwarding interface (include directories only)
add_library(nrf5_log_fwd INTERFACE)
target_include_directories(nrf5_log_fwd INTERFACE
  "${NRF5_SDK_PATH}/components/libraries/log"
  "${NRF5_SDK_PATH}/components/libraries/log/src"
)
list(APPEND NRF5_LIBRARY_NRF5_LOG_FWD_DEPENDENCIES
  nrf5_log_fwd
)

# CLI forwarding interface (include directories only)
add_library(nrf5_cli_fwd INTERFACE)
target_include_directories(nrf5_cli_fwd INTERFACE
  "${NRF5_SDK_PATH}/components/libraries/cli"
)
list(APPEND NRF5_LIBRARY_NRF5_CLI_FWD_DEPENDENCIES
  nrf5_cli_fwd
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
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_log_fwd
  nrf5_section
  nrf5_strerror
)
list(APPEND NRF5_LIBRARY_NRF5_SDH_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_config
  nrf5_log_fwd
  nrf5_mdk
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# Memory Object forwarding interface (include directories only)
add_library(nrf5_memobj_fwd INTERFACE)
target_include_directories(nrf5_memobj_fwd INTERFACE
  "${NRF5_SDK_PATH}/components/libraries/memobj"
)
list(APPEND NRF5_LIBRARY_NRF5_MEMOBJ_FWD_DEPENDENCIES
  nrf5_memobj_fwd
)

# Block Allocator forwarding interface (include directories only)
add_library(nrf5_balloc_fwd INTERFACE)
target_include_directories(nrf5_balloc_fwd INTERFACE
  "${NRF5_SDK_PATH}/components/libraries/balloc"
)
list(APPEND NRF5_LIBRARY_NRF5_BALLOC_FWD_DEPENDENCIES
  nrf5_balloc_fwd
)

# Block Allocator
add_library(nrf5_balloc OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/balloc/nrf_balloc.c"
)
target_include_directories(nrf5_balloc PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/balloc"
)
target_link_libraries(nrf5_balloc PUBLIC
  nrf5_cli_fwd
  nrf5_ext_fprintf
  nrf5_log_fwd
  nrf5_memobj_fwd
  nrf5_queue
  nrf5_section
  nrf5_soc
  nrf5_strerror
)
list(APPEND NRF5_LIBRARY_NRF5_BALLOC_DEPENDENCIES
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli_fwd
  nrf5_config
  nrf5_ext_fprintf
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj_fwd
  nrf5_queue
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# Memory Object
add_library(nrf5_memobj OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/memobj/nrf_memobj.c"
)
target_include_directories(nrf5_memobj PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/memobj"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_memobj PUBLIC
  nrf5_atomic
  nrf5_balloc
)
list(APPEND NRF5_LIBRARY_NRF5_MEMOBJ_DEPENDENCIES
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli_fwd
  nrf5_config
  nrf5_ext_fprintf
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_queue
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# Ring Buffer
add_library(nrf5_ringbuf OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/ringbuf/nrf_ringbuf.c"
)
target_include_directories(nrf5_ringbuf PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/ringbuf"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_ringbuf PUBLIC
  nrf5_atomic
)
list(APPEND NRF5_LIBRARY_NRF5_RINGBUF_DEPENDENCIES
  nrf5_atomic
  nrf5_config
  nrf5_mdk
  nrf5_ringbuf
  nrf5_soc
)

# Atomic FIFO
add_library(nrf5_atfifo OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/atomic_fifo/nrf_atfifo.c"
)
target_include_directories(nrf5_atfifo PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/atomic_fifo"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_atfifo PUBLIC
  nrf5_log_fwd
  nrf5_section
  nrf5_strerror
)
list(APPEND NRF5_LIBRARY_NRF5_ATFIFO_DEPENDENCIES
  nrf5_atfifo
  nrf5_config
  nrf5_log_fwd
  nrf5_mdk
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# Atomic Flags
add_library(nrf5_atflags OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/atomic_flags/nrf_atflags.c"
)
target_include_directories(nrf5_atflags PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/atomic_flags"
)
target_link_libraries(nrf5_atflags PUBLIC
  nrf5_atomic
)
list(APPEND NRF5_LIBRARY_NRF5_ATFLAGS_DEPENDENCIES
  nrf5_atflags
  nrf5_atomic
  nrf5_config
  nrf5_mdk
  nrf5_soc
)

# Queue
add_library(nrf5_queue OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/queue/nrf_queue.c"
)
target_include_directories(nrf5_queue PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/queue"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_queue PUBLIC
  nrf5_balloc_fwd
  nrf5_cli_fwd
  nrf5_ext_fprintf
  nrf5_log_fwd
  nrf5_memobj_fwd
  nrf5_section
  nrf5_strerror
)
list(APPEND NRF5_LIBRARY_NRF5_QUEUE_DEPENDENCIES
  nrf5_balloc_fwd
  nrf5_cli_fwd
  nrf5_config
  nrf5_ext_fprintf
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj_fwd
  nrf5_queue
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# Power management
add_library(nrf5_pwr_mgmt OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/pwr_mgmt/nrf_pwr_mgmt.c"
)
target_include_directories(nrf5_pwr_mgmt PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/pwr_mgmt"
)
target_link_libraries(nrf5_pwr_mgmt PUBLIC
  nrf5_app_util_platform
  nrf5_log_fwd
  nrf5_memobj
  nrf5_mtx
  nrf5_nrfx_hal
  nrf5_sdh
  nrf5_section
)
list(APPEND NRF5_LIBRARY_NRF5_PWR_MGMT_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_cli_fwd
  nrf5_config
  nrf5_ext_fprintf
  nrf5_log_fwd
  nrf5_mdk
  nrf5_memobj
  nrf5_memobj_fwd
  nrf5_mtx
  nrf5_nrfx_common
  nrf5_nrfx_hal
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# Stack Info
add_library(nrf5_stack_info INTERFACE)
target_include_directories(nrf5_stack_info INTERFACE
  "${NRF5_SDK_PATH}/components/libraries/stack_info"
)
list(APPEND NRF5_LIBRARY_NRF5_STACK_INFO_DEPENDENCIES
  nrf5_stack_info
)

# SVC
add_library(nrf5_svc OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/svc/nrf_svc_handler.c"
)
target_include_directories(nrf5_svc PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/svc"
)
target_link_libraries(nrf5_svc PUBLIC
  nrf5_section
)
list(APPEND NRF5_LIBRARY_NRF5_SVC_DEPENDENCIES
  nrf5_config
  nrf5_mdk
  nrf5_section
  nrf5_soc
  nrf5_svc
)

# Memory Manager
add_library(nrf5_mem_manager OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/mem_manager/mem_manager.c"
)
target_include_directories(nrf5_mem_manager PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/mem_manager"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_mem_manager PUBLIC
  nrf5_config
  nrf5_log_fwd
  nrf5_mdk
  nrf5_section
  nrf5_soc
  nrf5_strerror
)
list(APPEND NRF5_LIBRARY_NRF5_MEM_MANAGER_DEPENDENCIES
  nrf5_config
  nrf5_log_fwd
  nrf5_mdk
  nrf5_mem_manager
  nrf5_section
  nrf5_soc
  nrf5_strerror
)

# SHA256 library (includes only)
add_library(nrf5_sha256_fwd INTERFACE)
target_include_directories(nrf5_sha256_fwd INTERFACE
  "${NRF5_SDK_PATH}/components/libraries/sha256"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_sha256_fwd INTERFACE
  nrf5_config
  nrf5_soc
)
list(APPEND NRF5_LIBRARY_NRF5_SHA256_FWD_DEPENDENCIES
  nrf5_config
  nrf5_mdk
  nrf5_sha256_fwd
  nrf5_soc
)

# SHA256 library
add_library(nrf5_sha256 OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/sha256/sha256.c"
)
target_link_libraries(nrf5_sha256 PUBLIC
  nrf5_sha256_fwd
)
list(APPEND NRF5_LIBRARY_NRF5_SHA256_DEPENDENCIES
  nrf5_config
  nrf5_mdk
  nrf5_sha256
  nrf5_sha256_fwd
  nrf5_soc
)

# Sorted list library
add_library(nrf5_sortlist OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/sortlist/nrf_sortlist.c"
)
target_include_directories(nrf5_sortlist PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/sortlist"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_sortlist PUBLIC
  nrf5_config
  nrf5_log
  nrf5_mdk
  nrf5_soc
)
list(APPEND NRF5_LIBRARY_NRF5_SORTLIST_DEPENDENCIES
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
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_sortlist
  nrf5_strerror
)

# Default assert implementation
add_library(nrf5_assert OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/util/nrf_assert.c"
)
target_include_directories(nrf5_assert PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_assert PUBLIC
  nrf5_mdk
  nrf5_soc
)
list(APPEND NRF5_LIBRARY_NRF5_ASSERT_DEPENDENCIES
  nrf5_assert
  nrf5_mdk
  nrf5_soc
)

# Hardfault implementation
add_library(nrf5_hardfault OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/hardfault/hardfault_implementation.c"
)
target_include_directories(nrf5_hardfault PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/hardfault"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_hardfault PUBLIC
  nrf5_config
  nrf5_hardfault_handler
  nrf5_log
  nrf5_mdk
  nrf5_soc
)
list(APPEND NRF5_LIBRARY_NRF5_HARDFAULT_DEPENDENCIES
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
  nrf5_hardfault
  nrf5_hardfault_handler
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
