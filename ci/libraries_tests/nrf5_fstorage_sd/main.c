
#include <stddef.h>
#include "nrf_fstorage.h"
#include "nrf_fstorage_sd.h"

void app_error_handler_bare(uint32_t error_code)
{
}

void app_error_fault_handler(uint32_t id, uint32_t pc, uint32_t info)
{
}

int main()
{
    nrf_fstorage_t storage;
    nrf_fstorage_init(&storage, &nrf_fstorage_sd, NULL);
    return 0;
}