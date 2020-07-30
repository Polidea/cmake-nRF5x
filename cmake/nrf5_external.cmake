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
list(APPEND NRF5_LIBRARY_NRF5_EXT_FPRINTF_DEPENDENCIES
  nrf5_config
  nrf5_ext_fprintf
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
list(APPEND NRF5_LIBRARY_NRF5_EXT_SEGGER_RTT_DEPENDENCIES
  nrf5_app_util_platform
  nrf5_config
  nrf5_ext_segger_rtt
  nrf5_mdk
  nrf5_soc
)

# CC310 library forwarding interface (include directories only)
add_library(nrf5_ext_cc310_fwd INTERFACE)
target_include_directories(nrf5_ext_cc310_fwd INTERFACE
  "${NRF5_SDK_PATH}/external/nrf_cc310/include"
)
list(APPEND NRF5_LIBRARY_NRF5_EXT_CC310_FWD_DEPENDENCIES
  nrf5_ext_cc310_fwd
)

# CC310 BL library forwarding interface (include directories only)
add_library(nrf5_ext_cc310_bl_fwd INTERFACE)
target_include_directories(nrf5_ext_cc310_bl_fwd INTERFACE
  "${NRF5_SDK_PATH}/external/nrf_cc310_bl/include"
)
list(APPEND NRF5_LIBRARY_NRF5_EXT_CC310_BL_FWD_DEPENDENCIES
  nrf5_ext_cc310_bl_fwd
)

# Cifra AES128 EAX library (include directories only)
add_library(nrf5_ext_cifra_aes128_eax_fwd INTERFACE)
target_include_directories(nrf5_ext_cifra_aes128_eax_fwd INTERFACE
  "${NRF5_SDK_PATH}/external/cifra_AES128-EAX/"
)
list(APPEND NRF5_LIBRARY_NRF5_EXT_CIFRA_AES128_EAX_FWD_DEPENDENCIES
  nrf5_ext_cifra_aes128_eax_fwd
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
list(APPEND NRF5_LIBRARY_NRF5_EXT_CIFRA_AES128_EAX_DEPENDENCIES
  nrf5_ext_cifra_aes128_eax
  nrf5_ext_cifra_aes128_eax_fwd
)

# Oberon library forwarding interface (include directories only)
add_library(nrf5_ext_oberon_fwd INTERFACE)
target_include_directories(nrf5_ext_oberon_fwd INTERFACE
  "${NRF5_SDK_PATH}/external/nrf_oberon"
  "${NRF5_SDK_PATH}/external/nrf_oberon/include"
)
list(APPEND NRF5_LIBRARY_NRF5_EXT_OBERON_FWD_DEPENDENCIES
  nrf5_ext_oberon_fwd
)

# Optiga library forwarding interface (include directories only)
add_library(nrf5_ext_optiga_fwd INTERFACE)
target_include_directories(nrf5_ext_optiga_fwd INTERFACE
  "${NRF5_SDK_PATH}/external/infineon/optiga/include"
)
list(APPEND NRF5_LIBRARY_NRF5_EXT_OPTIGA_FWD_DEPENDENCIES
  nrf5_ext_optiga_fwd
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
list(APPEND NRF5_LIBRARY_NRF5_EXT_OPTIGA_DEPENDENCIES
  nrf5_app_scheduler
  nrf5_app_util_platform
  nrf5_atfifo
  nrf5_atomic
  nrf5_balloc
  nrf5_balloc_fwd
  nrf5_boards
  nrf5_cli
  nrf5_cli_fwd
  nrf5_config
  nrf5_crc16
  nrf5_delay
  nrf5_drv_rtc
  nrf5_drv_twi
  nrf5_ext_fprintf
  nrf5_ext_optiga
  nrf5_ext_optiga_fwd
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
  nrf5_nrfx_rtc
  nrf5_nrfx_twi
  nrf5_pwr_mgmt
  nrf5_queue
  nrf5_ringbuf
  nrf5_sdh
  nrf5_section
  nrf5_soc
  nrf5_strerror
  nrf5_twi_mngr
)

# The Dot Factory fonts
add_library(nrf5_ext_thedotfactory_fonts OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/external/thedotfactory_fonts/orkney24pts.c"
  "${NRF5_SDK_PATH}/external/thedotfactory_fonts/orkney8pts.c"
)
target_include_directories(nrf5_ext_thedotfactory_fonts PUBLIC
  "${NRF5_SDK_PATH}/external/thedotfactory_fonts"
)
list(APPEND NRF5_LIBRARY_NRF5_EXT_THEDOTFACTORY_FONTS_DEPENDENCIES
  nrf5_ext_thedotfactory_fonts
)

# fnmatch
add_library(nrf5_ext_fnmatch OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/external/fnmatch/fnmatch.c"
)
target_include_directories(nrf5_ext_fnmatch PUBLIC
  "${NRF5_SDK_PATH}/external/fnmatch"
)
list(APPEND NRF5_LIBRARY_NRF5_EXT_FNMATCH_DEPENDENCIES
  nrf5_ext_fnmatch
)

# UTF converter
add_library(nrf5_ext_utf_converter OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/external/utf_converter/utf.c"
)
target_include_directories(nrf5_ext_utf_converter PUBLIC
  "${NRF5_SDK_PATH}/external/utf_converter"
)
list(APPEND NRF5_LIBRARY_NRF5_EXT_UTF_CONVERTER_DEPENDENCIES
  nrf5_ext_utf_converter
)

# Mbed Crypto
add_library(nrf5_ext_mbedcrypto OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/external/mbedtls/library/aes.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/aesni.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/arc4.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/asn1parse.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/asn1write.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/base64.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/bignum.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/blowfish.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/camellia.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/ccm.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/cipher.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/cipher_wrap.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/cmac.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/ctr_drbg.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/des.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/dhm.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/ecdh.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/ecdsa.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/ecjpake.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/ecp.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/ecp_curves.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/entropy.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/entropy_poll.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/error.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/gcm.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/havege.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/hmac_drbg.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/md.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/md2.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/md4.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/md5.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/md_wrap.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/memory_buffer_alloc.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/oid.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/padlock.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/pem.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/pk.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/pk_wrap.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/pkcs12.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/pkcs5.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/pkparse.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/pkwrite.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/platform.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/ripemd160.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/rsa.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/sha1.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/sha256.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/sha512.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/threading.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/timing.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/version.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/version_features.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/xtea.c"
)
target_include_directories(nrf5_ext_mbedcrypto PUBLIC
  "${NRF5_SDK_PATH}/external/mbedtls/include"
  "${NRF5_SDK_PATH}/external/nrf_tls/mbedtls/nrf_crypto/config"
)
target_link_libraries(nrf5_ext_mbedcrypto PUBLIC
  nrf5_config
)
target_compile_options(nrf5_ext_mbedcrypto PUBLIC
  "$<$<OR:$<COMPILE_LANGUAGE:CXX>,$<COMPILE_LANGUAGE:C>>:-DMBEDTLS_CONFIG_FILE=\"nrf_crypto_mbedtls_config.h\">"
)
list(APPEND NRF5_LIBRARY_NRF5_EXT_MBEDCRYPTO_DEPENDENCIES
  nrf5_config
  nrf5_ext_mbedcrypto
)

# Mbed x509
add_library(nrf5_ext_mbedx509 OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/external/mbedtls/library/certs.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/pkcs11.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/x509.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/x509_create.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/x509_crl.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/x509_crt.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/x509_csr.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/x509write_crt.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/x509write_csr.c"
)
target_link_libraries(nrf5_ext_mbedx509 PUBLIC
  nrf5_ext_mbedcrypto
)
list(APPEND NRF5_LIBRARY_NRF5_EXT_MBEDX509_DEPENDENCIES
  nrf5_config
  nrf5_ext_mbedcrypto
  nrf5_ext_mbedx509
)

# Mbed TLS
add_library(nrf5_ext_mbedtls OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/external/mbedtls/library/debug.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/net_sockets.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/ssl_cache.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/ssl_ciphersuites.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/ssl_cli.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/ssl_cookie.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/ssl_srv.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/ssl_ticket.c"
  "${NRF5_SDK_PATH}/external/mbedtls/library/ssl_tls.c"
)
target_link_libraries(nrf5_ext_mbedtls PUBLIC
  nrf5_ext_mbedx509
)
list(APPEND NRF5_LIBRARY_NRF5_EXT_MBEDTLS_DEPENDENCIES
  nrf5_config
  nrf5_ext_mbedcrypto
  nrf5_ext_mbedtls
  nrf5_ext_mbedx509
)

# mbedTLS library forwarding interface (include directories only)
add_library(nrf5_ext_mbedtls_fwd INTERFACE)
target_include_directories(nrf5_ext_mbedtls_fwd INTERFACE
  "${NRF5_SDK_PATH}/external/mbedtls/include"
)
list(APPEND NRF5_LIBRARY_NRF5_EXT_MBEDTLS_FWD_DEPENDENCIES
  nrf5_ext_mbedtls_fwd
)

# Protothreads
add_library(nrf5_ext_protothreads INTERFACE)
target_include_directories(nrf5_ext_protothreads INTERFACE
  "${NRF5_SDK_PATH}/external/protothreads"
  "${NRF5_SDK_PATH}/external/protothreads/pt-1.4"
)
list(APPEND NRF5_LIBRARY_NRF5_EXT_PROTOTHREADS_DEPENDENCIES
  nrf5_ext_protothreads
)

# FatFs - Generic FAT file system module
add_library(nrf5_ext_fatfs OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/external/fatfs/src/ff.c"
)
target_include_directories(nrf5_ext_fatfs PUBLIC
  "${NRF5_SDK_PATH}/external/fatfs/src"
)
list(APPEND NRF5_LIBRARY_NRF5_EXT_FATFS_DEPENDENCIES
  nrf5_ext_fatfs
)

# FatFS disk I/O interface based on block device
add_library(nrf5_ext_fatfs_port_diskio_blkdev OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/external/fatfs/port/diskio_blkdev.c"
)
target_include_directories(nrf5_ext_fatfs_port_diskio_blkdev PUBLIC
  "${NRF5_SDK_PATH}/external/fatfs/port"
)
target_link_libraries(nrf5_ext_fatfs_port_diskio_blkdev PUBLIC
  nrf5_block_dev
  nrf5_ext_fatfs
  nrf5_mdk
  nrf5_soc
)
list(APPEND NRF5_LIBRARY_NRF5_EXT_FATFS_PORT_DISKIO_BLKDEV_DEPENDENCIES
  nrf5_block_dev
  nrf5_config
  nrf5_ext_fatfs
  nrf5_ext_fatfs_port_diskio_blkdev
  nrf5_mdk
  nrf5_soc
)

# Nanopb - Protocol Buffers for Embedded Systems
add_library(nrf5_ext_nanopb OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/external/nano-pb/pb_common.c"
  "${NRF5_SDK_PATH}/external/nano-pb/pb_decode.c"
  "${NRF5_SDK_PATH}/external/nano-pb/pb_encode.c"
)
target_include_directories(nrf5_ext_nanopb PUBLIC
  "${NRF5_SDK_PATH}/external/nano-pb"
)
list(APPEND NRF5_LIBRARY_NRF5_EXT_NANOPB_DEPENDENCIES
  nrf5_ext_nanopb
)
