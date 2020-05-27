#include "nrf_atflags.h"

int main()
{
    nrf_atflags_t flags;
    nrf_atflags_init(&flags, 1, 1);
    return 0;
}