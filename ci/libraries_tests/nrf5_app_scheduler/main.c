#include "app_scheduler.h"

int main()
{
    uint8_t buffer[8];
    app_sched_init(8, 1, buffer);
    return 0;
}