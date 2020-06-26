#include <stdbool.h>
#include "nrf_cli_rtt.h"

NRF_CLI_RTT_DEF(rtt_cli);

int main()
{
    rtt_cli.p_cb->p_context = NULL;
    return 0;
}