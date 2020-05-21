#include <stdint.h>
#include <stdbool.h>
#include "nrf_ble_lesc.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    nrf_ble_lesc_init();
    return 0;
}