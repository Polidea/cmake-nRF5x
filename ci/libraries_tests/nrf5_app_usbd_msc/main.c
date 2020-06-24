#include "app_usbd_msc.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    app_usbd_msc_t msc;
    app_usbd_msc_sync(&msc);
    return 0;
}