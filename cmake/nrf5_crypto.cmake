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

# Crypto
add_library(nrf5_crypto OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_aead.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_aes.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_aes_shared.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_ecc.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_ecdh.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_ecdsa.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_eddsa.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_error.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_hash.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_hkdf.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_hmac.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_init.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_rng.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/nrf_crypto_shared.c"
)
target_include_directories(nrf5_crypto PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/crypto"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310_bl"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cifra"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/mbedtls"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/micro_ecc"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/nrf_hw"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/nrf_sw"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/oberon"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/optiga"
  "${NRF5_SDK_PATH}/components/libraries/experimental_section_vars"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_crypto PUBLIC
  nrf5_config
  nrf5_ext_cc310_bl_fwd
  nrf5_ext_cc310_fwd
  nrf5_ext_cifra_aes128_eax_fwd
  nrf5_ext_mbedtls_fwd
  nrf5_ext_micro_ecc_fwd
  nrf5_log
  nrf5_mem_manager
  nrf5_soc
  nrf5_stack_info
)

# Crypto CC310 backend
add_library(nrf5_crypto_cc310_backend OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_aes.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_aes_aead.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_chacha_poly_aead.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_ecc.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_ecdh.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_ecdsa.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_eddsa.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_hash.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_hmac.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_init.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_mutex.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_rng.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310/cc310_backend_shared.c"
)
target_include_directories(nrf5_crypto_cc310_backend PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_crypto_cc310_backend PUBLIC
  nrf5_crypto
  nrf5_ext_cc310_fwd
  nrf5_mtx
  nrf5_nrfx_common
)

# Crypto CC310 BL backend
add_library(nrf5_crypto_cc310_bl_backend OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310_bl/cc310_bl_backend_ecc.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310_bl/cc310_bl_backend_ecdsa.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310_bl/cc310_bl_backend_hash.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310_bl/cc310_bl_backend_init.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310_bl/cc310_bl_backend_shared.c"
)
target_include_directories(nrf5_crypto_cc310_bl_backend PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cc310_bl"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_crypto_cc310_bl_backend PUBLIC
  nrf5_crypto
  nrf5_ext_cc310_bl_fwd
)

# Crypto Cifra backend
add_library(nrf5_crypto_cifra_backend OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cifra/cifra_backend_aes_aead.c"
)
target_include_directories(nrf5_crypto_cifra_backend PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/cifra"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_crypto_cifra_backend PUBLIC
  nrf5_config
  nrf5_crypto
  nrf5_ext_cifra_aes128_eax
  nrf5_mdk
  nrf5_soc
)

# Crypto mbedTLS backend
add_library(nrf5_crypto_mbedtls_backend OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/mbedtls/mbedtls_backend_aes.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/mbedtls/mbedtls_backend_aes_aead.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/mbedtls/mbedtls_backend_ecc.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/mbedtls/mbedtls_backend_ecdh.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/mbedtls/mbedtls_backend_ecdsa.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/mbedtls/mbedtls_backend_hash.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/mbedtls/mbedtls_backend_hmac.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/mbedtls/mbedtls_backend_init.c"
)
target_include_directories(nrf5_crypto_mbedtls_backend PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/mbedtls"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_crypto_mbedtls_backend PUBLIC
  nrf5_crypto
  nrf5_ext_mbedtls_fwd
  nrf5_mdk
  nrf5_nrfx_common
  nrf5_soc
)

# Crypto micro-ecc backend
add_library(nrf5_crypto_micro_ecc_backend OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/micro_ecc/micro_ecc_backend_ecc.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/micro_ecc/micro_ecc_backend_ecdh.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/micro_ecc/micro_ecc_backend_ecdsa.c"
)
target_include_directories(nrf5_crypto_micro_ecc_backend PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/micro_ecc"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_crypto_micro_ecc_backend PUBLIC
  micro_ecc
  nrf5_config
  nrf5_crypto
  nrf5_mdk
  nrf5_soc
)

# Crypto Oberon backend
add_library(nrf5_crypto_oberon_backend OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/oberon/oberon_backend_chacha_poly_aead.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/oberon/oberon_backend_ecc.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/oberon/oberon_backend_ecdh.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/oberon/oberon_backend_ecdsa.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/oberon/oberon_backend_eddsa.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/oberon/oberon_backend_hash.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/oberon/oberon_backend_hmac.c"
)
target_include_directories(nrf5_crypto_oberon_backend PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/oberon"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_crypto_oberon_backend PUBLIC
  nrf5_config
  nrf5_crypto_fwd
  nrf5_mdk
  nrf5_soc
)

# Crypto nRF HW backend
add_library(nrf5_crypto_nrf_hw_backend OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/nrf_hw/nrf_hw_backend_init.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/nrf_hw/nrf_hw_backend_rng.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/nrf_hw/nrf_hw_backend_rng_mbedtls.c"
)
target_include_directories(nrf5_crypto_nrf_hw_backend PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/nrf_hw"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_crypto_nrf_hw_backend PUBLIC
  nrf5_config
  nrf5_crypto
  nrf5_drv_rng
  nrf5_mdk
  nrf5_soc
)

# Crypto nRF SW backend
add_library(nrf5_crypto_nrf_sw_backend OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/nrf_sw/nrf_sw_backend_hash.c"
)
target_include_directories(nrf5_crypto_nrf_sw_backend PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/nrf_sw"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_crypto_nrf_sw_backend PUBLIC
  nrf5_config
  nrf5_crypto_fwd
  nrf5_mdk
  nrf5_soc
)

# Crypto Optiga backend
add_library(nrf5_crypto_optiga_backend OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/optiga/optiga_backend_ecc.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/optiga/optiga_backend_ecdh.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/optiga/optiga_backend_ecdsa.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/optiga/optiga_backend_init.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/optiga/optiga_backend_rng.c"
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/optiga/optiga_backend_utils.c"
)
target_include_directories(nrf5_crypto_optiga_backend PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/crypto/backend/optiga"
  "${NRF5_SDK_PATH}/components/libraries/util"
)
target_link_libraries(nrf5_crypto_optiga_backend PUBLIC
  nrf5_config
  nrf5_crypto_fwd
  nrf5_mdk
  nrf5_soc
)
