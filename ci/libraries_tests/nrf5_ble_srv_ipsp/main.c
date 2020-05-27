#include "ble_ipsp.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    ble_ipsp_init_t init;
    ble_ipsp_init(&init);
    return 0;
}