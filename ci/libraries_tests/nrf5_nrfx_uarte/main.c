
#include "nrfx_uarte.h"

void nrfx_uarte_event_handler(nrfx_uarte_event_t const *p_event, void *p_context)
{
}

int main()
{
    nrfx_uarte_t uarte;
    nrfx_uarte_config_t uarte_config;
    nrfx_uarte_init(&uarte, &uarte_config, nrfx_uarte_event_handler);
    return 0;
}