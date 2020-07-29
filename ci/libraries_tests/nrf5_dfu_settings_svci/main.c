#include "nrf_dfu_settings.h"

void clbk(void* buf)
{
}

int main()
{
  nrf_dfu_settings_init(false);
  nrf_dfu_settings_write(clbk);
  nrf_dfu_settings_peer_data_write(NULL);

  return 0;
}
