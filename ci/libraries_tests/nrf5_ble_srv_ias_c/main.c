#include "ble_ias_c.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    ble_ias_c_t ias_c;
    ble_ias_c_init_t ias_c_init;
    ble_ias_c_init(&ias_c, &ias_c_init);
    return 0;
}