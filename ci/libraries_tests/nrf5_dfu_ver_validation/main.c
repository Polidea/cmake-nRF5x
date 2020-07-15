#include "nrf_dfu_ver_validation.h"

int main()
{
  dfu_init_command_t init_cmd = {0};
  nrf_dfu_ver_validation_check(&init_cmd);

  return 0;
}
