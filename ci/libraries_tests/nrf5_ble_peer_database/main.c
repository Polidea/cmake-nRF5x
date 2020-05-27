#include <stdint.h>
#include <stdbool.h>
#include "peer_database.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    pdb_init();
    return 0;
}