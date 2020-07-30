#include "nrf_dfu_transport.h"

DFU_TRANSPORT_REGISTER(nrf_dfu_transport_t const dfu_transport) =
{
    .init_func  = NULL,
    .close_func = NULL,
};

int main()
{
  nrf_dfu_transports_init(NULL);
  return 0;
}
