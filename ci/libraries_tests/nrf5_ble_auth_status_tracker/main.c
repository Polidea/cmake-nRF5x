#include <stdint.h>
#include <stdbool.h>
#include "auth_status_tracker.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    ast_init();
    return 0;
}