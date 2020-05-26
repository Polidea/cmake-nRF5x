
#include "nrf_section.h"

int data = 4;

NRF_SECTION_DEF(my_section, int);
NRF_SECTION_ITEM_REGISTER(my_section, int data);

int main()
{
    return 0;
}