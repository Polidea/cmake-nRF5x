#include <stdint.h>
#include "ble_advertising.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    ble_advertising_t adv = {};
    ble_advertising_init_t adv_init = {};
    ble_advertising_init(&adv, &adv_init);
    return 0;
}