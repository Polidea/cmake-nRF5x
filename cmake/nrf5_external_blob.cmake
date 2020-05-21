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

# Additional information used for selecting proper libs.
get_property(nrf5_mdk_compile_options TARGET nrf5_mdk PROPERTY "COMPILE_OPTIONS")

# Check CPU type.
set(cpu_type "")

list(FIND nrf5_mdk_compile_options "-mcpu=cortex-m0" cpu_available)
if (NOT cpu_available EQUAL -1)
  set(cpu_type "cortex-m0")
endif()

list(FIND nrf5_mdk_compile_options "-mcpu=cortex-m33" cpu_available)
if (NOT cpu_available EQUAL -1)
  set(cpu_type "cortex-m33")
endif()

list(FIND nrf5_mdk_compile_options "-mcpu=cortex-m4" cpu_available)
if (NOT cpu_available EQUAL -1)
  set(cpu_type "cortex-m4")
endif()

# Check FPU
set(float_abi "")

list(FIND nrf5_mdk_compile_options "-mfloat-abi=soft" float_abi_soft)
if (NOT float_abi_soft EQUAL -1)
  set(float_abi "soft-float")
endif()

list(FIND nrf5_mdk_compile_options "-mfloat-abi=hard" float_abi_hard)
if (NOT float_abi_hard EQUAL -1)
  set(float_abi "hard-float")
endif()

# Check wchar size
set(short_wchar "")

list(FIND nrf5_mdk_compile_options "-fshort-wchar" is_short_wchar)
if (NOT is_short_wchar EQUAL -1)
  set(short_wchar "short-wchar")
endif()


# CC310 library

set(cc310_interrupts "")
file(STRINGS "${NRF5_SDKCONFIG_PATH}/sdk_config.h" sdk_config_file)
string(REGEX MATCH "NRF_CRYPTO_BACKEND_CC310_INTERRUPTS_ENABLED 1" cc310_interrupts_enabled "${sdk_config_file}")
if(NOT cc310_interrupts_enabled)
  set(cc310_interrupts "no-interrupts")
endif()

set(cc310_variant "${cpu_type}/${float_abi}/${short_wchar}/${cc310_interrupts}")
set(cc310_lib_path "${NRF5_SDK_PATH}/external/nrf_cc310/lib/${cc310_variant}/libnrf_cc310_0.9.12.a")

if(EXISTS "${cc310_lib_path}")
  target_link_libraries(nrf5_crypto_cc310_backend PUBLIC "${cc310_lib_path}")
endif()

# CC310 BL library

set(cc310_bl_interrupts "")
file(STRINGS "${NRF5_SDKCONFIG_PATH}/sdk_config.h" sdk_config_file)
string(REGEX MATCH "NRF_CRYPTO_BACKEND_CC310_BL_INTERRUPTS_ENABLED 1" cc310_bl_interrupts_enabled "${sdk_config_file}")
if(NOT cc310_bl_interrupts_enabled)
  set(cc310_bl_interrupts "no-interrupts")
endif()

set(cc310_bl_variant "${cpu_type}/${float_abi}/${short_wchar}/${cc310_bl_interrupts}")
set(cc310_bl_lib_path "${NRF5_SDK_PATH}/external/nrf_cc310_bl/lib/${cc310_bl_variant}/libnrf_cc310_bl_0.9.12.a")

if(EXISTS "${cc310_bl_lib_path}")
  target_link_libraries(nrf5_crypto_cc310_bl_backend PUBLIC "${cc310_bl_lib_path}")
endif()
