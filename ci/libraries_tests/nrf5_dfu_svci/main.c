#include <stdint.h>

uint32_t nrf_dfu_svci_vector_table_set(void);
uint32_t nrf_dfu_svci_vector_table_unset(void);

int main()
{
  nrf_dfu_svci_vector_table_set();
  nrf_dfu_svci_vector_table_set();

  return 0;
}
