#include "nrf_ble_bms.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    nrf_ble_bms_t bms;
    nrf_ble_bms_init_t bms_init;
    nrf_ble_bms_init(&bms, &bms_init);
    return 0;
}