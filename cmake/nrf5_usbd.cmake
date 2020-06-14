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
)
target_include_directories(nrf5_app_usbd INTERFACE
  "${NRF5_SDK_PATH}/components/libraries/usbd"
)
target_link_libraries(nrf5_app_usbd PUBLIC
  nrf5_drv_usbd
)

# USB Device high level library core module
add_library(nrf5_app_usbd_core OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/usbd/app_usbd_core.c"
)
target_link_libraries(nrf5_app_usbd_core PUBLIC
  nrf5_app_usbd
)

# USBD serial number generator
add_library(nrf5_app_usbd_serial_num OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/usbd/app_usbd_serial_num.c"
)
target_link_libraries(nrf5_app_usbd_serial_num PUBLIC
  nrf5_app_usbd
)

# USBD string descriptors
add_library(nrf5_app_usbd_string_desc OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/usbd/app_usbd_string_desc.c"
)
target_link_libraries(nrf5_app_usbd_string_desc PUBLIC
  nrf5_app_usbd
  nrf5_ext_utf_converter
)
