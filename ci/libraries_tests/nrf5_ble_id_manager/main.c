#include <stdint.h>
#include <stdbool.h>
#include "id_manager.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    ble_gap_addr_t addr;
    im_id_addr_get(&addr);
    return 0;
}