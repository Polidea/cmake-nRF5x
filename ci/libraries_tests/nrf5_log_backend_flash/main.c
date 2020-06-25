#include "nrf_log.h"
#include "nrf_log_backend_flash.h"

int main()
{
    nrf_log_backend_flash_init(NULL);

    return 0;
}
