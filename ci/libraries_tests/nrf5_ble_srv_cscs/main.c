#include "ble_cscs.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    ble_cscs_t cscs;
    ble_cscs_init_t cscs_init;
    ble_cscs_init(&cscs, &cscs_init);
    return 0;
}