#include "ble_ans_c.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    ble_ans_c_t ans;
    ble_ans_c_init_t ans_init;
    ble_ans_c_init(&ans, &ans_init);
    return 0;
}