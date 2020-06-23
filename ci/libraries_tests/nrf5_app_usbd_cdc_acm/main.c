#include "app_usbd_cdc_acm.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    app_usbd_cdc_acm_t dc_acm;
    char buffer[] = {0};
    app_usbd_cdc_acm_write(&dc_acm, buffer, sizeof(buffer));
    return 0;
}