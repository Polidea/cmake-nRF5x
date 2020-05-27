#include <stdint.h>
#include <stdbool.h>
#include "gatt_cache_manager.h"
#include "gatts_cache_manager.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    gcm_init();
    gscm_init();
    return 0;
}