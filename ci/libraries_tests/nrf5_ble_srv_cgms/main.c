#include "cgms_db.h"
#include "cgms_meas.h"
#include "cgms_racp.h"
#include "cgms_socp.h"
#include "cgms_sst.h"

void app_error_handler_bare(uint32_t error_code)
{
}

int main()
{
    cgms_db_init();
    cgms_meas_char_add(NULL);
    cgms_racp_char_add(NULL);
    cgms_socp_char_add(NULL);
    cgms_sst_char_add(NULL);
    return 0;
}