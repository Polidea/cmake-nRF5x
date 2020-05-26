#include "ble_dis.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    ble_dis_init_t init;
    ble_dis_init(&init);
    return 0;
}