#include <stddef.h>
#include "nrf_atfifo.h"

int main()
{
    nrf_atfifo_t fifo = {};
    uint8_t buf[8];
    nrf_atfifo_init(&fifo, buf, 8, 2);
    return 0;
}