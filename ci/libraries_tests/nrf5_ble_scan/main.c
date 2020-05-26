#include "nrf_ble_scan.h"

void app_error_handler_bare(uint32_t error_code)
{
}

void nrf_ble_scan_evt_handler(scan_evt_t const *p_scan_evt)
{
}

int main()
{
    nrf_ble_scan_t ble_scan;
    nrf_ble_scan_init_t ble_scan_init;
    nrf_ble_scan_init(&ble_scan, &ble_scan_init, nrf_ble_scan_evt_handler);
    return 0;
}