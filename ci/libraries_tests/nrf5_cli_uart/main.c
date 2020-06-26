#include <stdbool.h>
#include "nrf_cli_uart.h"

NRF_CLI_UART_DEF(cli_uart, 0, 64, 16);

int main()
{
    cli_uart.p_cb->p_context = NULL;
    return 0;
}