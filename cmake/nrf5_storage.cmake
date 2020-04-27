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

# File storage
add_library(nrf5_fstorage OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/fstorage/nrf_fstorage.c"
  "${NRF5_SDK_PATH}/components/libraries/fstorage/nrf_fstorage_sd.c"
)
target_include_directories(nrf5_fstorage PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/fstorage"
)
target_link_libraries(nrf5_fstorage PUBLIC
  nrf5_section nrf5_log_fwd nrf5_strerror nrf5_sdh nrf5_atomic nrf5_atfifo
)

# File data storage
add_library(nrf5_fds OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/fds/fds.c"
)
target_include_directories(nrf5_fds PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/fds"
)
target_link_libraries(nrf5_fds PUBLIC nrf5_fstorage)
