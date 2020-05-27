#include <stdint.h>
#include <stdbool.h>
#include "peer_data_storage.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    pm_peer_id_t id = 0;
    pds_peer_id_free(id);
    return 0;
}