#include <stdint.h>
#include <stdbool.h>
#include "peer_manager.h"

void app_error_handler_bare(uint32_t error_code)
{
}

void app_error_fault_handler(uint32_t id, uint32_t pc, uint32_t info)
{
}

int main()
{
    pm_init();
    return 0;
}