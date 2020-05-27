
#include <stddef.h>
#include "nrf_fstorage.h"

int main()
{
    nrf_fstorage_t storage;
    nrf_fstorage_api_t api;
    nrf_fstorage_init(&storage, &api, NULL);
    return 0;
}