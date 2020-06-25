#include "ble_bps.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    ble_bps_t bps;
    ble_bps_init_t bps_init;
    ble_bps_init(&bps, &bps_init);
    return 0;
}