#include <stdint.h>
#include <stdbool.h>
#include "ble_db_discovery.h"

void ble_db_discovery_evt_handler(ble_db_discovery_evt_t *p_evt)
{
}

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    ble_db_discovery_init(ble_db_discovery_evt_handler);
    return 0;
}