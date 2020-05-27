
#include "nrf_log.h"
#include "nrf_log_backend_rtt.h"

int main()
{
    nrf_log_backend_rtt_init();
    nrf_log_push("OK");
    return 0;
}