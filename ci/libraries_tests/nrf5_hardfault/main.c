#include "hardfault.h"

void HardFault_c_handler(uint32_t *p_stack_address);
void HardFault_Handler(void);

int main()
{
    uint32_t value = 0;
    HardFault_c_handler(&value);
    HardFault_Handler();
    return 0;
}