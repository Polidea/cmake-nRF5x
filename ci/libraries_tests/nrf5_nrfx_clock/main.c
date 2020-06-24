#include "nrfx_clock.h"

void nrfx_clock_event_handler(nrfx_clock_evt_type_t event)
{
}

int main()
{
    nrfx_clock_init(nrfx_clock_event_handler);
    return 0;
}