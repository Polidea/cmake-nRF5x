
#include "nrf_crypto.h"
#include "nrf_crypto_aead.h"

int main()
{
    nrf_crypto_aead_context_t context;
    uint8_t key[] = {0x00};
    nrf_crypto_aead_init(&context, &g_nrf_crypto_aes_eax_128_info, key);
    return 0;
}