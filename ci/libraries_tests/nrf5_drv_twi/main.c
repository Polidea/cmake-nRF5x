
#include "nrf_drv_twi.h"

void twi_handler(nrf_drv_twi_evt_t const *p_event, void *p_context)
{
}

int main()
{
    nrf_drv_twi_t twi;
    nrf_drv_twi_config_t config;
    nrf_drv_twi_init(&twi, &config, twi_handler, NULL);
}