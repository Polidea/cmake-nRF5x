
#include "nrf_drv_uart.h"

void nrf_uart_event_handler(nrf_drv_uart_event_t *p_event, void *p_context)
{
}

int main()
{
    nrf_drv_uart_t uart;
    nrf_drv_uart_config_t uart_config;
    nrf_drv_uart_init(&uart, &uart_config, nrf_uart_event_handler);
    return 0;
}