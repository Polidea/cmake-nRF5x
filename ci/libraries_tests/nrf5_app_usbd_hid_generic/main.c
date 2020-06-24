#include "app_usbd_hid_generic.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    app_usbd_class_inst_t inst;
    hid_generic_clear_buffer(&inst);
    return 0;
}