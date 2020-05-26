#include "nrf_ble_qwr.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    nrf_ble_qwr_t qwr;
    nrf_ble_qwr_init_t qwr_init;
    nrf_ble_qwr_init(&qwr, &qwr_init);
    return 0;
}