#include "ble_hts.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    ble_hts_t hts;
    ble_hts_init_t hts_init;
    ble_hts_init(&hts, &hts_init);
    return 0;
}