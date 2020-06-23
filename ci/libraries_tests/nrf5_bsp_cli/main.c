#include <stdbool.h>
#include "bsp_cli.h"

void bsp_event_callback(bsp_event_t event)
{
}

int main()
{
    bsp_cli_init(bsp_event_callback);
    return 0;
}