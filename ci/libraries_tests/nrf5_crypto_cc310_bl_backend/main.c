
#include "nrf_crypto.h"
#include "nrf_crypto_ecc.h"

int main()
{
    nrf_crypto_ecc_key_pair_generate_context_t context;
    nrf_crypto_ecc_private_key_t private;
    nrf_crypto_ecc_public_key_t public;
    nrf_crypto_ecc_key_pair_generate(&context, &g_nrf_crypto_ecc_secp256r1_curve_info, &private, &public);

    return 0;
}