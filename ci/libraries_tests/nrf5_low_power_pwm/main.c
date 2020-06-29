#include "low_power_pwm.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    low_power_pwm_init(NULL, NULL, NULL);

    return 0;
}
