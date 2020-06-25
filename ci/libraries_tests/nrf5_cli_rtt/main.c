#include "nrf_cli_rtt.h"

NRF_CLI_RTT_DEF(m_cli_rtt_transport);
NRF_CLI_DEF(m_cli_rtt, "", &m_cli_rtt_transport.transport, '\r', 0);

int main()
{
    nrf_cli_init(&m_cli_rtt, NULL, true, true, NRF_LOG_SEVERITY_INFO);

    return 0;
}
