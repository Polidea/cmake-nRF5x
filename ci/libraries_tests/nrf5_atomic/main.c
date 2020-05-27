#include "nrf_atomic.h"

int main()
{
    nrf_atomic_u32_t atomic;
    nrf_atomic_u32_add(&atomic, 32);
    return 0;
}