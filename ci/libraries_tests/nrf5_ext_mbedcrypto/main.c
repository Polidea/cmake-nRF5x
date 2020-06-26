#include "mbedtls/aes.h"

int main()
{
    mbedtls_aes_context ctx;
    uint8_t key[] = {0x00};
    mbedtls_aes_setkey_dec(&ctx, key, 8);
}