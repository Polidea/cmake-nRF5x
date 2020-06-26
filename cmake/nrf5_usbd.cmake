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

# USB Device high level library
add_library(nrf5_app_usbd OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/usbd/app_usbd.c"
  "${NRF5_SDK_PATH}/components/libraries/usbd/app_usbd_core.c"
  "${NRF5_SDK_PATH}/components/libraries/usbd/app_usbd_string_desc.c"
)
target_include_directories(nrf5_app_usbd INTERFACE
  "${NRF5_SDK_PATH}/components/libraries/usbd"
)
target_link_libraries(nrf5_app_usbd PUBLIC
  nrf5_drv_clock
  nrf5_drv_power
  nrf5_drv_usbd
  nrf5_ext_utf_converter
)
list(APPEND NRF5_LIBRARY_NRF5_APP_USBD_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_usbd
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
  nrf5_drv_power
  nrf5_drv_usbd
  nrf5_ext_fprintf
  nrf5_ext_utf_converter
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
  nrf5_nrfx_power
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

# USBD serial number generator
add_library(nrf5_app_usbd_serial_num OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/usbd/app_usbd_serial_num.c"
)
target_link_libraries(nrf5_app_usbd_serial_num PUBLIC
  nrf5_app_usbd
)
list(APPEND NRF5_LIBRARY_NRF5_APP_USBD_SERIAL_NUM_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_usbd
  nrf5_app_usbd_serial_num
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
  nrf5_drv_power
  nrf5_drv_usbd
  nrf5_ext_fprintf
  nrf5_ext_utf_converter
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
  nrf5_nrfx_power
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

# USB CDC ACM class
add_library(nrf5_app_usbd_cdc_acm OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/usbd/class/cdc/acm/app_usbd_cdc_acm.c"
)
target_include_directories(nrf5_app_usbd_cdc_acm PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/usbd/class/cdc"
  "${NRF5_SDK_PATH}/components/libraries/usbd/class/cdc/acm"
)
target_link_libraries(nrf5_app_usbd_cdc_acm PUBLIC
  nrf5_app_usbd
)
list(APPEND NRF5_LIBRARY_NRF5_APP_USBD_CDC_ACM_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_usbd
  nrf5_app_usbd_cdc_acm
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
  nrf5_drv_power
  nrf5_drv_usbd
  nrf5_ext_fprintf
  nrf5_ext_utf_converter
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
  nrf5_nrfx_power
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

# USB HID class
add_library(nrf5_app_usbd_hid OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/usbd/class/hid/app_usbd_hid.c"
)
target_include_directories(nrf5_app_usbd_hid PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/usbd/class/hid"
)
target_link_libraries(nrf5_app_usbd_hid PUBLIC
  nrf5_app_usbd
)
list(APPEND NRF5_LIBRARY_NRF5_APP_USBD_HID_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_usbd
  nrf5_app_usbd_hid
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
  nrf5_drv_power
  nrf5_drv_usbd
  nrf5_ext_fprintf
  nrf5_ext_utf_converter
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
  nrf5_nrfx_power
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

# USB HID generic
add_library(nrf5_app_usbd_hid_generic OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/usbd/class/hid/generic/app_usbd_hid_generic.c"
)
target_include_directories(nrf5_app_usbd_hid_generic PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/usbd/class/hid/generic"
)
target_link_libraries(nrf5_app_usbd_hid_generic PUBLIC
  nrf5_app_usbd_hid
)
list(APPEND NRF5_LIBRARY_NRF5_APP_USBD_HID_GENERIC_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_usbd
  nrf5_app_usbd_hid
  nrf5_app_usbd_hid_generic
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
  nrf5_drv_power
  nrf5_drv_usbd
  nrf5_ext_fprintf
  nrf5_ext_utf_converter
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
  nrf5_nrfx_power
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

# USB HID keyboard
add_library(nrf5_app_usbd_hid_kbd OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/usbd/class/hid/kbd/app_usbd_hid_kbd.c"
)
target_include_directories(nrf5_app_usbd_hid_kbd PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/usbd/class/hid/kbd"
)
target_link_libraries(nrf5_app_usbd_hid_kbd PUBLIC
  nrf5_app_usbd_hid
)
list(APPEND NRF5_LIBRARY_NRF5_APP_USBD_HID_KBD_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_usbd
  nrf5_app_usbd_hid
  nrf5_app_usbd_hid_kbd
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
  nrf5_drv_power
  nrf5_drv_usbd
  nrf5_ext_fprintf
  nrf5_ext_utf_converter
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
  nrf5_nrfx_power
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

# USB HID mouse
add_library(nrf5_app_usbd_hid_mouse OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/usbd/class/hid/mouse/app_usbd_hid_mouse.c"
)
target_include_directories(nrf5_app_usbd_hid_mouse PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/usbd/class/hid/mouse"
)
target_link_libraries(nrf5_app_usbd_hid_mouse PUBLIC
  nrf5_app_usbd_hid
)
list(APPEND NRF5_LIBRARY_NRF5_APP_USBD_HID_MOUSE_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_usbd
  nrf5_app_usbd_hid
  nrf5_app_usbd_hid_mouse
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
  nrf5_drv_power
  nrf5_drv_usbd
  nrf5_ext_fprintf
  nrf5_ext_utf_converter
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
  nrf5_nrfx_power
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

# USB MSC class
add_library(nrf5_app_usbd_msc OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/usbd/class/msc/app_usbd_msc.c"
)
target_include_directories(nrf5_app_usbd_msc PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/usbd/class/msc"
)
target_link_libraries(nrf5_app_usbd_msc PUBLIC
  nrf5_app_usbd
  nrf5_block_dev
)
list(APPEND NRF5_LIBRARY_NRF5_APP_USBD_MSC_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_usbd
  nrf5_app_usbd_msc
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_block_dev
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_clock
  nrf5_drv_power
  nrf5_drv_usbd
  nrf5_ext_fprintf
  nrf5_ext_utf_converter
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
  nrf5_nrfx_power
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

# USB AUDIO class
add_library(nrf5_app_usbd_audio OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/usbd/class/audio/app_usbd_audio.c"
)
target_include_directories(nrf5_app_usbd_audio PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/usbd/class/audio"
)
target_link_libraries(nrf5_app_usbd_audio PUBLIC
  nrf5_app_usbd
)
list(APPEND NRF5_LIBRARY_NRF5_APP_USBD_AUDIO_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_usbd
  nrf5_app_usbd_audio
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
  nrf5_drv_power
  nrf5_drv_usbd
  nrf5_ext_fprintf
  nrf5_ext_utf_converter
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
  nrf5_nrfx_power
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

# USB Dummy class
add_library(nrf5_app_usbd_dummy OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/usbd/class/dummy/app_usbd_dummy.c"
)
target_include_directories(nrf5_app_usbd_dummy PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/usbd/class/dummy"
)
target_link_libraries(nrf5_app_usbd_dummy PUBLIC
  nrf5_app_usbd
  nrf5_block_dev
)
list(APPEND NRF5_LIBRARY_NRF5_APP_USBD_DUMMY_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_usbd
  nrf5_app_usbd_dummy
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_block_dev
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_clock
  nrf5_drv_power
  nrf5_drv_usbd
  nrf5_ext_fprintf
  nrf5_ext_utf_converter
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
  nrf5_nrfx_power
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

# USB Nordic DFU Trigger class
add_library(nrf5_app_usbd_nrf_dfu_trigger OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/usbd/class/nrf_dfu_trigger/app_usbd_nrf_dfu_trigger.c"
)
target_include_directories(nrf5_app_usbd_nrf_dfu_trigger PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/usbd/class/nrf_dfu_trigger"
)
target_link_libraries(nrf5_app_usbd_nrf_dfu_trigger PUBLIC
  nrf5_app_usbd
  nrf5_block_dev
)
list(APPEND NRF5_LIBRARY_NRF5_APP_USBD_NRF_DFU_TRIGGER_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_usbd
  nrf5_app_usbd_nrf_dfu_trigger
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_block_dev
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_clock
  nrf5_drv_power
  nrf5_drv_usbd
  nrf5_ext_fprintf
  nrf5_ext_utf_converter
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
  nrf5_nrfx_power
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
