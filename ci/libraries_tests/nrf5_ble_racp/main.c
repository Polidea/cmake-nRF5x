#include "ble_racp.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    ble_racp_value_t value;
    uint8_t data[] = {0};
    ble_racp_encode(&value, data);
    return 0;
}