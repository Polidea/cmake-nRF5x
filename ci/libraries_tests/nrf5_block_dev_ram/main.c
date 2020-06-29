#include "nrf_block_dev.h"
#include "nrf_block_dev_ram.h"

int main()
{
    nrf_block_dev_ram_ops_get(NULL);

    return 0;
}
