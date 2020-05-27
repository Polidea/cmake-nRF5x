#include <stdbool.h>
#include "nrf_ble_gq.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    nrf_ble_gq_t gq;
    nrf_ble_gq_req_t gq_req;

    nrf_ble_gq_item_add(&gq, &gq_req, 0);
    return 0;
}