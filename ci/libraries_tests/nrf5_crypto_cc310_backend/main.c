
#include "nrf_crypto.h"
#include "nrf_crypto_aes.h"

int main()
{
    nrf_crypto_aes_context_t aes_context;
    nrf_crypto_aes_init(&aes_context, &g_nrf_crypto_aes_cbc_128_info, NRF_CRYPTO_DECRYPT);
    return 0;
}