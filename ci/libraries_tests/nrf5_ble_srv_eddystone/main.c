#include <stddef.h>
#include "nrf_ble_es.h"
#include "es_adv.h"
#include "es_adv_frame.h"
#include "es_adv_timing.h"
#include "es_adv_timing_resolver.h"
#include "es_battery_voltage.h"
#include "es_flash.h"
#include "es_gatts.h"
#include "es_gatts_read.h"
#include "es_gatts_write.h"
#include "es_security.h"
#include "es_slot.h"
#include "es_slot_reg.h"
#include "es_stopwatch.h"
#include "es_tlm.h"
#include "es_util.h"

void app_error_handler_bare(uint32_t error_code)
{
}

void app_error_fault_handler(uint32_t id, uint32_t pc, uint32_t info)
{
}

int main()
{
    es_adv_timers_init();
    es_adv_frame_fill_connectable_adv_data(NULL, NULL);
    es_adv_timing_resolve(NULL);
    es_adv_timing_init(NULL);
    es_battery_voltage_get(NULL);
    es_flash_init();
    es_gatts_read_handle_unlock(NULL);
    es_gatts_write_handle_unlock(NULL, NULL, 0, 0);
    es_gatts_init(NULL);
    es_security_init(NULL);
    es_slot_reg_init(NULL);
    es_slots_init(NULL);
    es_stopwatch_init();
    es_tlm_init();
    nrf_ble_es_init(NULL);
    return 0;
}