#include <stdint.h>
#include <stdbool.h>
#include "peer_manager_handler.h"

void app_error_handler_bare(uint32_t error_code)
{
}

void app_error_fault_handler(uint32_t id, uint32_t pc, uint32_t info)
{
}

int main()
{
    pm_evt_t event;
    pm_handler_on_pm_evt(&event);
    return 0;
}