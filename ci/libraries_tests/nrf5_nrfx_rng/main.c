#include "nrfx_rng.h"

void nrfx_rng_evt_handler(uint8_t rng_data)
{
}

int main()
{
    nrfx_rng_config_t config;
    nrfx_rng_init(&config, nrfx_rng_evt_handler);
    return 0;
}