
#include "nrfx_rtc.h"

void nrfx_rtc_handler(nrfx_rtc_int_type_t int_type)
{
}

int main()
{
    nrfx_rtc_t rtc;
    nrfx_rtc_config_t config;
    nrfx_rtc_init(&rtc, &config, nrfx_rtc_handler);
    return 0;
}