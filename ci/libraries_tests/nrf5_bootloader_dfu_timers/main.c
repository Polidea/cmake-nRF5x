#include "stddef.h"
#include "nrf_bootloader_dfu_timers.h"

int main()
{
  nrf_bootloader_wdt_feed_timer_start(32768, NULL);
  return 0;
}
