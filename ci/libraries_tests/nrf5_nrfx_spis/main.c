#include "nrfx_spis.h"

void nrfx_spis_evt_handler(nrfx_spis_evt_t const *p_event, void *p_context)
{
}

int main()
{
    nrfx_spis_t spis;
    nrfx_spis_config_t config;
    nrfx_spis_init(&spis, &config, nrfx_spis_evt_handler, NULL);
    return 0;
}