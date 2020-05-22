#include "nrf_drv_rng.h"

int main()
{
    nrf_drv_rng_config_t config;
    nrf_drv_rng_init(&config);
    return 0;
}