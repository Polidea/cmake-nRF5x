#include "nrf_drv_spis.h"

void nrf_drv_spis_event_handler(nrf_drv_spis_event_t event)
{
}

int main()
{
    nrf_drv_spis_t spis;
    nrf_drv_spis_config_t config;
    nrf_drv_spis_init(&spis, &config, nrf_drv_spis_event_handler);
    return 0;
}