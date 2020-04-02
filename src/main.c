#include <stdbool.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif
	
#include "nrf_delay.h"
#include "nrf_gpio.h"
	
#ifdef __cplusplus
}
#endif


int main(void)
{
  const uint32_t led1_pin = NRF_GPIO_PIN_MAP(0, 13);
  
  nrf_gpio_cfg_output(led1_pin);

	for (;;)
	{
  	nrf_gpio_pin_set(led1_pin);
		nrf_delay_ms(500);
  	nrf_gpio_pin_clear(led1_pin);
		nrf_delay_ms(500);
	}
}
