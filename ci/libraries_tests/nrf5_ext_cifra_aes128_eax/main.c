
#include "cifra_eax_aes.h"

int main()
{
    cf_aes_context context;
    uint8_t key[] = {0x00};
    cf_aes_init(&context, key, 1);
    return 0;
}