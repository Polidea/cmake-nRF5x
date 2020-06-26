#include "ble_bas.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    ble_bas_t bas;
    ble_bas_init_t bas_init;
    ble_bas_init(&bas, &bas_init);
    return 0;
}