#include "nrf_cli_cdc_acm.h"

NRF_CLI_CDC_ACM_DEF(m_cli_cdc_acm_transport);
NRF_CLI_DEF(m_cli_cdc_acm, "", &m_cli_cdc_acm_transport.transport, '\r', 0);

int main()
{
    nrf_cli_init(&m_cli_cdc_acm, NULL, true, true, NRF_LOG_SEVERITY_INFO);

    return 0;
}
