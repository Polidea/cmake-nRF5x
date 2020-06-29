#include "ble_ots.h"
#include "ble_ots_l2cap.h"
#include "ble_ots_oacp.h"
#include "ble_ots_object.h"

void app_error_handler_bare(uint32_t error_code)
{
}

void app_error_fault_handler(uint32_t id, uint32_t pc, uint32_t info)
{
}

int main()
{
    ble_ots_init(NULL, NULL);
    ble_ots_l2cap_is_channel_available(NULL);
    ble_ots_oacp_on_ble_evt(NULL, NULL);
    ble_ots_object_representation_init(NULL, NULL);
    return 0;
}