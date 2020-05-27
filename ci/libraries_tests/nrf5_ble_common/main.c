#include <stdint.h>
#include <stdbool.h>
#include "ble_conn_state.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    ble_conn_state_init();
    return 0;
}