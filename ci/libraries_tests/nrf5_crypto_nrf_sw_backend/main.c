
#include "nrf_crypto.h"
#include "nrf_crypto_hash.h"

int main()
{
    nrf_crypto_hash_context_t context;
    nrf_crypto_hash_init(&context, &g_nrf_crypto_hash_sha256_info);
    return 0;
}