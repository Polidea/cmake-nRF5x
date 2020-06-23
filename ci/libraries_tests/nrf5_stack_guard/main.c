#include "sdk_errors.h"
#include "nrf_stack_guard.h"

int main()
{
    nrf_stack_guard_init();
    return 0;
}