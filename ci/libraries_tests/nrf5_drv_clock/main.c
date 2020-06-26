#include "nrf_drv_clock.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    nrf_drv_clock_init();
    return 0;
}