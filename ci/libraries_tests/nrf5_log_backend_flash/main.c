
#include "nrf_log.h"
#include "nrf_log_backend_flash.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    nrf_fstorage_api_t api;
    nrf_log_backend_flash_init(&api);
    nrf_log_push("OK");
    return 0;
}