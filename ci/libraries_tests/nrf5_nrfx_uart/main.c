
#include "nrfx_uart.h"

void nrfx_uart_event_handler(nrfx_uart_event_t const *p_event, void *p_context)
{
}

int main()
{
    nrfx_uart_t uart;
    nrfx_uart_config_t uart_config;
    nrfx_uart_init(&uart, &uart_config, nrfx_uart_event_handler);
    return 0;
}