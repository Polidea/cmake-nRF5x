
#include "nrf_nvmc.h"

int main()
{
    nrf_nvmc_page_erase(0x00);
    return 0;
}