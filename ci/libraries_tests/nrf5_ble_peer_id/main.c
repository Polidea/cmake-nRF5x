#include <stdint.h>
#include <stdbool.h>
#include "peer_id.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    pm_peer_id_t id = 0;
    peer_id_delete(id);
    return 0;
}