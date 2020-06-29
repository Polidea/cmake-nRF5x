#include "ble_ias.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    ble_ias_t ias;
    ble_ias_init_t ias_init;
    ble_ias_init(&ias, &ias_init);
    return 0;
}