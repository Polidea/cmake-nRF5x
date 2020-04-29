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

# fprintf
add_library(nrf5_ext_fprintf OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/external/fprintf/nrf_fprintf.c"
  "${NRF5_SDK_PATH}/external/fprintf/nrf_fprintf_format.c"
)
target_include_directories(nrf5_ext_fprintf PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/external/fprintf"
)
target_link_libraries(nrf5_ext_fprintf PUBLIC nrf5_mdk nrf5_soc nrf5_config)

# Segger RTT
add_library(nrf5_ext_segger_rtt OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/external/segger_rtt/SEGGER_RTT.c"
)
target_include_directories(nrf5_ext_segger_rtt PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/external/segger_rtt"
)
target_link_libraries(nrf5_ext_segger_rtt PUBLIC nrf5_config nrf5_mdk nrf5_soc)

# CC310 library forwarding interface (include directories only)
add_library(nrf5_ext_cc310_fwd INTERFACE)
target_include_directories(nrf5_ext_cc310_fwd INTERFACE
  "${NRF5_SDK_PATH}/external/nrf_cc310/include"
)

# mbedTLS library forwarding interface (include directories only)
add_library(nrf5_ext_mbedtls_fwd INTERFACE)
target_include_directories(nrf5_ext_mbedtls_fwd INTERFACE
  "${NRF5_SDK_PATH}/external/mbedtls/include"
)
