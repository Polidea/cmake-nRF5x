#include "crc16.h"

int main()
{
    uint8_t data[] = {0x00};
    uint16_t crc;
    crc16_compute(data, 1, &crc);
    return 0;
}