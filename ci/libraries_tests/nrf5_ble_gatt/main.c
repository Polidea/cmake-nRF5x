#include <stdint.h>
#include <stdbool.h>
#include "nrf_ble_gatt.h"

void app_error_handler_bare(uint32_t error_code)
{
}

void nrf_ble_gatt_evt_handler(nrf_ble_gatt_t *p_gatt, nrf_ble_gatt_evt_t const *p_evt)
{
}

int main()
{
    nrf_ble_gatt_t gatt;
    nrf_ble_gatt_init(&gatt, nrf_ble_gatt_evt_handler);
    return 0;
}