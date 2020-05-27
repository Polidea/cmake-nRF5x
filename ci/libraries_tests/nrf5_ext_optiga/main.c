#include "optiga/optiga_crypt.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    uint8_t random[] = {0x00};
    optiga_crypt_random(OPTIGA_RNG_TYPE_TRNG, random, 1);
    return 0;
}