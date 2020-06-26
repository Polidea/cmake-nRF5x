#include "app_usbd.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    app_usbd_config_t config;
    app_usbd_init(&config);
    return 0;
}