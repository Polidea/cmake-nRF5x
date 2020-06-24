#include "nrf_sortlist.h"

int main()
{
    nrf_sortlist_t sortlist;
    nrf_sortlist_item_t item;
    nrf_sortlist_add(&sortlist, &item);
    return 0;
}