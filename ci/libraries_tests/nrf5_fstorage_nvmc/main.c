
#include <stddef.h>
#include "nrf_fstorage.h"
#include "nrf_fstorage_nvmc.h"

int main()
{
    nrf_fstorage_t storage;
    nrf_fstorage_init(&storage, &nrf_fstorage_nvmc, NULL);
    return 0;
}