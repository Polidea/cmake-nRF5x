
#include "nrfx_prs.h"

int main()
{
    nrfx_prs_acquire(NULL, nrfx_prs_box_0_irq_handler);
    return 0;
}