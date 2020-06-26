#include "app_usbd_audio.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    app_usbd_class_inst_t inst;
    app_usbd_audio_class_rx_size_get(&inst);
    return 0;
}