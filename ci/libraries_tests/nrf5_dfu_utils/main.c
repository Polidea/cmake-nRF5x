#include "nrf_dfu_utils.h"

int main()
{
  nrf_dfu_cache_prepare(0x1000, true, true, true);
  return 0;
}
