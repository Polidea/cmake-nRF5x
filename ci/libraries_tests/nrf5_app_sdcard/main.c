#include "app_sdcard.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    app_sdc_init(NULL, NULL);

    return 0;
}