
#include "nrfx_twi.h"

void twi_handler(nrfx_twi_evt_t const *p_event, void *p_context)
{
}

int main()
{
    nrfx_twi_t twi;
    nrfx_twi_config_t config;
    nrfx_twi_init(&twi, &config, twi_handler, NULL);
    return 0;
}