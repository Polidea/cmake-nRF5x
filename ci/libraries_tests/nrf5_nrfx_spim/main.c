#include "nrfx_spim.h"

void nrfx_spim_evt_handler(nrfx_spim_evt_t const *p_event, void *p_context)
{
}

int main()
{
    nrfx_spim_t spim;
    nrfx_spim_config_t config;
    nrfx_spim_init(&spim, &config, nrfx_spim_evt_handler, NULL);
    return 0;
}