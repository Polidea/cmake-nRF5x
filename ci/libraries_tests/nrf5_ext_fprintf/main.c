
#include "nrf_fprintf.h"

int main()
{
    nrf_fprintf_ctx_t context;
    nrf_fprintf(&context, "Hello");
    return 0;
}