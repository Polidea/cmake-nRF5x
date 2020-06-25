#include "ble_rscs.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    ble_rscs_t rscs;
    ble_rscs_init_t rscs_init;
    ble_rscs_init(&rscs, &rscs_init);
    return 0;
}