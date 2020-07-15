#include "stddef.h"
#include "nrf_dfu_flash.h"

int main()
{
  uint8_t buf[64];

  nrf_dfu_flash_init(false);
  nrf_dfu_flash_store(0x1000, buf, sizeof(buf), NULL);

  return 0;
}
