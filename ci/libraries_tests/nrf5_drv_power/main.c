#include "nrfx_power.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    nrfx_power_config_t config;
    nrfx_power_init(&config);
    return 0;
}