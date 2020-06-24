#include "nrf_assert.h"

void app_error_fault_handler(uint32_t id, uint32_t pc, uint32_t info)
{
}

int main()
{
    assert_nrf_callback(0, (const uint8_t *)"nrf_assert");
    return 0;
}