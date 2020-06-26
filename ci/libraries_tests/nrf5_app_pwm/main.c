#include "app_pwm.h"

int main()
{
    app_pwm_config_t cfg = {0};
    app_pwm_init(NULL, &cfg, NULL);

    return 0;
}
