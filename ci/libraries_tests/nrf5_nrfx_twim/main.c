
#include "nrfx_twim.h"

void twi_handler(nrfx_twim_evt_t const *p_event, void *p_context)
{
}

int main()
{
    nrfx_twim_t twi;
    nrfx_twim_config_t config;
    nrfx_twim_init(&twi, &config, twi_handler, NULL);
    return 0;
}