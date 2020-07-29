#include "nrf_bootloader_info.h"

int main()
{
  nrf_bootloader_mbr_addrs_populate();
  nrf_bootloader_debug_port_disable();
  
  return 0;
}
