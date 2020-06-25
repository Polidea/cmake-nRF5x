#include "crc32.h"

int main()
{
    uint8_t data[] = {0x00};
    uint32_t crc;
    crc32_compute(data, 1, &crc);
    
    return 0;
}
