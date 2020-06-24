#include "nrfx_usbd.h"

void nrfx_usbd_event_handler(nrfx_usbd_evt_t const *p_event)
{
}

int main()
{
    nrfx_usbd_init(nrfx_usbd_event_handler);
    return 0;
}