#include "app_fifo.h"

int main()
{
    app_fifo_t t = {};
    uint8_t buffer[2] = {};
    app_fifo_init(&t, buffer, 2);
    return 0;
}