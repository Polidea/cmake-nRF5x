#include "app_usbd_hid.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    app_usbd_class_inst_t class_inst;
    app_usbd_hid_inst_t hid_inst;
    app_usbd_hid_ctx_t hid_ctx;
    app_usbd_complex_evt_t evt;

    app_usbd_hid_event_handler(&class_inst, &hid_inst, &hid_ctx, &evt);
    return 0;
}