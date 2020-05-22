
#include "nrf_crypto.h"
#include "nrf_crypto_rng.h"

int main()
{
    nrf_crypto_rng_context_t context;
    nrf_crypto_rng_temp_buffer_t buffer;
    nrf_crypto_rng_init(&context, &buffer);

    return 0;
}