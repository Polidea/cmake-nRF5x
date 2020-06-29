#include "ble_tps.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    ble_tps_t tps;
    ble_tps_init_t tps_init;
    ble_tps_init(&tps, &tps_init);
    return 0;
}