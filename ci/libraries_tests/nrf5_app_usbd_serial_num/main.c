#include "app_usbd_serial_num.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    app_usbd_serial_num_generate();
    return 0;
}