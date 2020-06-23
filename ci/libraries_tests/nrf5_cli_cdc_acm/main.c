#include <stdbool.h>
#include "nrf_cli_cdc_acm.h"

NRF_CLI_CDC_ACM_DEF(hello);

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    hello.p_cb->p_context = NULL;
    return 0;
}