
#include "nrf_crypto.h"
#include "nrf_crypto_ecc.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    nrf_crypto_ecc_key_pair_generate_context_t context2;
    nrf_crypto_ecc_private_key_t private;
    nrf_crypto_ecc_public_key_t public;
    nrf_crypto_ecc_key_pair_generate(&context2, &g_nrf_crypto_ecc_secp256r1_curve_info, &private, &public);
    return 0;
}