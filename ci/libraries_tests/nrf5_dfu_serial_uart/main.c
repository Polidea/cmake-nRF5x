#include "nrf_dfu_serial.h"

int main()
{
  nrf_dfu_serial_t serial_transport;
  nrf_dfu_serial_on_packet_received(&serial_transport, NULL, 0);

  return 0;
}
