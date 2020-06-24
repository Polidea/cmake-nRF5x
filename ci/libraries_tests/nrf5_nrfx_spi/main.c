#include "nrfx_spi.h"

void nrfx_spi_evt_handler(nrfx_spi_evt_t const *p_event, void *p_context)
{
}

int main()
{
    nrfx_spi_t spi;
    nrfx_spi_config_t config;
    nrfx_spi_init(&spi, &config, nrfx_spi_evt_handler, NULL);
    return 0;
}