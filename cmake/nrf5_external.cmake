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

# fprintf
add_library(nrf5_ext_fprintf OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/external/fprintf/nrf_fprintf.c"
  "${NRF5_SDK_PATH}/external/fprintf/nrf_fprintf_format.c"
)
target_include_directories(nrf5_ext_fprintf PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/external/fprintf"
)
target_link_libraries(nrf5_ext_fprintf PUBLIC
  nrf5_config
  nrf5_mdk
  nrf5_soc
)

# Segger RTT
add_library(nrf5_ext_segger_rtt OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/external/segger_rtt/SEGGER_RTT.c"
  "${NRF5_SDK_PATH}/external/segger_rtt/SEGGER_RTT_Syscalls_GCC.c"
  "${NRF5_SDK_PATH}/external/segger_rtt/SEGGER_RTT_printf.c"
)
target_include_directories(nrf5_ext_segger_rtt PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/external/segger_rtt"
)
target_link_libraries(nrf5_ext_segger_rtt PUBLIC
  nrf5_app_util_platform
  nrf5_config
  nrf5_mdk
  nrf5_soc
)

# CC310 library forwarding interface (include directories only)
add_library(nrf5_ext_cc310_fwd INTERFACE)
target_include_directories(nrf5_ext_cc310_fwd INTERFACE
  "${NRF5_SDK_PATH}/external/nrf_cc310/include"
)

# CC310 BL library forwarding interface (include directories only)
add_library(nrf5_ext_cc310_bl_fwd INTERFACE)
target_include_directories(nrf5_ext_cc310_bl_fwd INTERFACE
  "${NRF5_SDK_PATH}/external/nrf_cc310_bl/include"
)

# Cifra AES128 EAX library (include directories only)
add_library(nrf5_ext_cifra_aes128_eax_fwd INTERFACE)
target_include_directories(nrf5_ext_cifra_aes128_eax_fwd INTERFACE
  "${NRF5_SDK_PATH}/external/cifra_AES128-EAX/"
)

# Cifra AES128 EAX library
add_library(nrf5_ext_cifra_aes128_eax OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/external/cifra_AES128-EAX/blockwise.c"
  "${NRF5_SDK_PATH}/external/cifra_AES128-EAX/cifra_cmac.c"
  "${NRF5_SDK_PATH}/external/cifra_AES128-EAX/cifra_eax_aes.c"
  "${NRF5_SDK_PATH}/external/cifra_AES128-EAX/eax.c"
  "${NRF5_SDK_PATH}/external/cifra_AES128-EAX/gf128.c"
  "${NRF5_SDK_PATH}/external/cifra_AES128-EAX/modes.c"
)
target_link_libraries(nrf5_ext_cifra_aes128_eax PUBLIC
  nrf5_ext_cifra_aes128_eax_fwd
)

# mbedTLS library forwarding interface (include directories only)
add_library(nrf5_ext_mbedtls_fwd INTERFACE)
target_include_directories(nrf5_ext_mbedtls_fwd INTERFACE
  "${NRF5_SDK_PATH}/external/mbedtls/include"
)

# Oberon library forwarding interface (include directories only)
add_library(nrf5_ext_oberon_fwd INTERFACE)
target_include_directories(nrf5_ext_oberon_fwd INTERFACE
  "${NRF5_SDK_PATH}/external/nrf_oberon"
  "${NRF5_SDK_PATH}/external/nrf_oberon/include"
)

# Optiga library forwarding interface (include directories only)
add_library(nrf5_ext_optiga_fwd INTERFACE)
target_include_directories(nrf5_ext_optiga_fwd INTERFACE
  "${NRF5_SDK_PATH}/external/infineon/optiga/include"
)

# Optiga library
add_library(nrf5_ext_optiga OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/external/infineon/optiga/cmd/CommandLib.c"
  "${NRF5_SDK_PATH}/external/infineon/optiga/common/Logger.c"
  "${NRF5_SDK_PATH}/external/infineon/optiga/common/Util.c"
  "${NRF5_SDK_PATH}/external/infineon/optiga/comms/ifx_i2c/ifx_i2c.c"
  "${NRF5_SDK_PATH}/external/infineon/optiga/comms/ifx_i2c/ifx_i2c_config.c"
  "${NRF5_SDK_PATH}/external/infineon/optiga/comms/ifx_i2c/ifx_i2c_data_link_layer.c"
  "${NRF5_SDK_PATH}/external/infineon/optiga/comms/ifx_i2c/ifx_i2c_physical_layer.c"
  "${NRF5_SDK_PATH}/external/infineon/optiga/comms/ifx_i2c/ifx_i2c_transport_layer.c"
  "${NRF5_SDK_PATH}/external/infineon/optiga/comms/optiga_comms.c"
  "${NRF5_SDK_PATH}/external/infineon/optiga/crypt/optiga_crypt.c"
  "${NRF5_SDK_PATH}/external/infineon/optiga/util/optiga_util.c"
  "${NRF5_SDK_PATH}/external/infineon/pal/nrf5x/pal_gpio.c"
  "${NRF5_SDK_PATH}/external/infineon/pal/nrf5x/pal_i2c.c"
  "${NRF5_SDK_PATH}/external/infineon/pal/nrf5x/pal_ifx_i2c_config.c"
  "${NRF5_SDK_PATH}/external/infineon/pal/nrf5x/pal_os.c"
  "${NRF5_SDK_PATH}/external/infineon/pal/nrf5x/pal_os_lock.c"
)
target_link_libraries(nrf5_ext_optiga PUBLIC
  nrf5_boards
  nrf5_drv_rtc
  nrf5_ext_optiga_fwd
  nrf5_nrfx_rtc
  nrf5_pwr_mgmt
  nrf5_twi_mngr
)
target_compile_options(nrf5_ext_optiga PUBLIC
  "$<$<OR:$<COMPILE_LANGUAGE:CXX>,$<COMPILE_LANGUAGE:C>>:-DDL_MAX_FRAME_SIZE=250>"
)
target_compile_options(nrf5_ext_optiga PUBLIC
  "$<$<COMPILE_LANGUAGE:ASM>:-DDL_MAX_FRAME_SIZE=250>"
)
if(NRF5_SDK_VERSION VERSION_EQUAL 16.0.0)
  target_sources(nrf5_ext_optiga PRIVATE
    "${NRF5_SDK_PATH}/external/infineon/examples/ecdsa_utils/ecdsa_utils.c"
  )
  target_include_directories(nrf5_ext_optiga PUBLIC
    "${NRF5_SDK_PATH}/external/infineon/examples/ecdsa_utils"
  )
endif()

# The Dot Factory fonts
add_library(nrf5_ext_thedotfactory_fonts OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/external/thedotfactory_fonts/orkney24pts.c"
  "${NRF5_SDK_PATH}/external/thedotfactory_fonts/orkney8pts.c"
)
target_include_directories(nrf5_ext_thedotfactory_fonts PUBLIC
  "${NRF5_SDK_PATH}/external/thedotfactory_fonts"
)
