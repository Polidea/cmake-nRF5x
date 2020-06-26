#include "ble_hids.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    ble_hids_t hids;
    ble_hids_init_t hids_init;
    ble_hids_init(&hids, &hids_init);
    return 0;
}