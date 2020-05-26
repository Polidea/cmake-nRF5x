
#include "nrf_log.h"
#include "nrf_log_backend_serial.h"

void nrf_fprintf_fwrite_func(void const *p_user_ctx, char const *p_str, size_t length)
{
}

int main()
{
    nrf_log_backend_t backend;
    nrf_log_entry_t entry;
    uint8_t buf[] = {0x00};
    nrf_log_backend_serial_put(&backend,
                               &entry,
                               buf,
                               1,
                               nrf_fprintf_fwrite_func);
    nrf_log_push("OK");
    return 0;
}