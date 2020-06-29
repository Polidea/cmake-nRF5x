#include "led_softblink.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    led_sb_init_params_t init_params = LED_SB_INIT_DEFAULT_PARAMS(0);
    led_softblink_init(&init_params);

    return 0;
}
