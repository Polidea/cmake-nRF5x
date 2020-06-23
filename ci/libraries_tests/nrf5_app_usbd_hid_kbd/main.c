#include "app_usbd_hid_kbd.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    app_usbd_hid_kbd_t kbd;
    app_usbd_hid_kbd_modifier_state_set(&kbd, APP_USBD_HID_KBD_MODIFIER_RIGHT_UI, true);
    return 0;
}