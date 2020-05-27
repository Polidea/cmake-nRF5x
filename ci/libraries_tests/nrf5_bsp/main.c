#include "bsp.h"

void app_error_handler_bare(uint32_t error_code)
{
}

void bsp_event_callback(bsp_event_t event)
{
}

int main()
{
    bsp_init(0, bsp_event_callback);
    return 0;
}