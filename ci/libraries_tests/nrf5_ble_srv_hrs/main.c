#include "ble_hrs.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    ble_hrs_t hrs;
    ble_hrs_init_t hrs_init;
    ble_hrs_init(&hrs, &hrs_init);
    return 0;
}