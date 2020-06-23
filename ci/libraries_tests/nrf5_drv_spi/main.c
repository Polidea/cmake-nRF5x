#include "nrf_spi.h"

int main()
{
    NRF_SPI_Type *type = NULL;
    nrf_spi_event_t event = NRF_SPI_EVENT_READY;
    nrf_spi_event_check(type, event);
    return 0;
}