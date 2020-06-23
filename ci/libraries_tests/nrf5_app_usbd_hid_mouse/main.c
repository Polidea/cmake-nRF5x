#include "app_usbd_hid_mouse.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    app_usbd_hid_mouse_t mouse;
    app_usbd_hid_mouse_y_move(&mouse, 0);
    return 0;
}