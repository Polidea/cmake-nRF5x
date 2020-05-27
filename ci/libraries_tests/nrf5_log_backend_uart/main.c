
#include "nrf_log.h"
#include "nrf_log_backend_uart.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    nrf_log_backend_uart_init();
    nrf_log_push("OK");
    return 0;
}