
#include "nrf_twi_mngr.h"

int main()
{
    nrf_twi_mngr_t mngr;
    nrf_drv_twi_config_t twi_config;
    nrf_twi_mngr_init(&mngr, &twi_config);
    return 0;
}