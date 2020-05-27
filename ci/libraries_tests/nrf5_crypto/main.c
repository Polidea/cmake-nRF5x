#include "nrf_crypto.h"

int main()
{
    nrf_crypto_init();

    nrf_crypto_aead_context_t aead_ctx;
    nrf_crypto_aead_info_t aead_info;
    uint8_t aead_key[] = {0xFF};
    nrf_crypto_aead_init(&aead_ctx, &aead_info, aead_key);

    nrf_crypto_aes_context_t aes_ctx;
    nrf_crypto_aes_info_t aes_info;
    nrf_crypto_aes_init(&aes_ctx, &aes_info, NRF_CRYPTO_ENCRYPT);

    uint8_t padding_pkcs7_msg[] = {0x00};
    size_t padding_pkcs7_msg_len = 1;
    padding_pkcs7_remove(padding_pkcs7_msg, &padding_pkcs7_msg_len);

    nrf_crypto_error_string_get(80);

    nrf_crypto_hash_context_t hash_ctx;
    nrf_crypto_hash_info_t hash_info;
    nrf_crypto_hash_init(&hash_ctx, &hash_info);

    nrf_crypto_hmac_context_t hmac_ctx;
    nrf_crypto_hmac_info_t hmac_info;
    uint8_t hmac_key[] = {0x00};
    nrf_crypto_hmac_init(&hmac_ctx, &hmac_info, hmac_key, 1);

    uint8_t hmac_out[] = {0x00};
    size_t hmac_out_len = 1;
    uint8_t hmac_in[] = {0x00};
    size_t hmac_in_len = 1;
    uint8_t hmac_salt[] = {0x00};
    size_t hmac_salt_len = 1;
    uint8_t hmac_ainfo[] = {0x00};
    size_t hmac_ainfo_len = 1;
    nrf_crypto_hkdf_calculate(&hmac_ctx,
                              &hmac_info,
                              hmac_out,
                              &hmac_out_len,
                              hmac_in,
                              hmac_in_len,
                              hmac_salt,
                              hmac_salt_len,
                              hmac_ainfo,
                              hmac_ainfo_len,
                              NRF_CRYPTO_HKDF_EXTRACT_AND_EXPAND);

    return 0;
}