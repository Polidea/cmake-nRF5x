#include "ble_cts_c.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    ble_cts_c_t cts;
    ble_cts_c_init_t cts_init;
    ble_cts_c_init(&cts, &cts_init);
    return 0;
}