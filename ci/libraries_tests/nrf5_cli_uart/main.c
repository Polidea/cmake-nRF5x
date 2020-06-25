#include "nrf_cli_uart.h"

NRF_CLI_UART_DEF(m_cli_uart_transport, 0, 64, 16);
NRF_CLI_DEF(m_cli_uart, "", &m_cli_uart_transport.transport, '\r', 0);

int main()
{
    nrf_cli_init(&m_cli_uart, NULL, true, true, NRF_LOG_SEVERITY_INFO);

    return 0;
}
