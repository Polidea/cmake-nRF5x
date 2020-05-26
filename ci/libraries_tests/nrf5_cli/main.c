#include <stdbool.h>
#include "nrf_cli.h"

int main()
{
    nrf_cli_t cli;
    nrf_cli_init(&cli, NULL, false, false, NRF_LOG_SEVERITY_INFO_RAW);
    return 0;
}