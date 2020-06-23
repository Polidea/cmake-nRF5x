#include "nrfx_atomic.h"

int main()
{
    nrfx_atomic_u32_t value = 0;
    nrfx_atomic_u32_add(&value, 1);
    return 0;
}