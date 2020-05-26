#include <stdint.h>
#include <stdbool.h>
#include "pm_buffer.h"

void app_error_handler_bare(uint32_t error_code)
{
}

void app_error_fault_handler(uint32_t id, uint32_t pc, uint32_t info)
{
}

int main()
{
    pm_buffer_t buffer;
    nrf_atflags_t mutex;
    uint8_t buffer_mem[] = {0x0ff};
    pm_buffer_init(&buffer, buffer_mem, 1, &mutex, 1, 1);
    return 0;
}