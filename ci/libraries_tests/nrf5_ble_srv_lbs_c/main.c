#include "ble_lbs_c.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    ble_lbs_c_t lbs;
    ble_lbs_c_init_t lbs_init;
    ble_lbs_c_init(&lbs, &lbs_init);
    return 0;
}