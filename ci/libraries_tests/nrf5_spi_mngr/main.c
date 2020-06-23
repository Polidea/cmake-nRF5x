#include "nrf_spi_mngr.h"

int main()
{
    nrf_spi_mngr_t mngr;
    nrf_drv_spi_config_t config;
    nrf_spi_mngr_init(&mngr, &config);
    return 0;
}