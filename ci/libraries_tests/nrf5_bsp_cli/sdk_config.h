#ifndef SDK_CONFIG_H
#define SDK_CONFIG_H

#ifndef NRF_LOG_ENABLED
#define NRF_LOG_ENABLED 0
#endif

// <h> nrf_cli - Command line interface

//==========================================================
// <q> NRF_CLI_ENABLED  - Enable/disable the CLI module.

#ifndef NRF_CLI_ENABLED
#define NRF_CLI_ENABLED 1
#endif

// <o> NRF_CLI_ARGC_MAX - Maximum number of parameters passed to the command handler.
#ifndef NRF_CLI_ARGC_MAX
#define NRF_CLI_ARGC_MAX 12
#endif

// <q> NRF_CLI_BUILD_IN_CMDS_ENABLED  - CLI built-in commands.

#ifndef NRF_CLI_BUILD_IN_CMDS_ENABLED
#define NRF_CLI_BUILD_IN_CMDS_ENABLED 1
#endif

// <o> NRF_CLI_CMD_BUFF_SIZE - Maximum buffer size for a single command.
#ifndef NRF_CLI_CMD_BUFF_SIZE
#define NRF_CLI_CMD_BUFF_SIZE 128
#endif

// <q> NRF_CLI_ECHO_STATUS  - CLI echo status. If set, echo is ON.

#ifndef NRF_CLI_ECHO_STATUS
#define NRF_CLI_ECHO_STATUS 1
#endif

// <q> NRF_CLI_WILDCARD_ENABLED  - Enable wildcard functionality for CLI commands.

#ifndef NRF_CLI_WILDCARD_ENABLED
#define NRF_CLI_WILDCARD_ENABLED 0
#endif

// <q> NRF_CLI_METAKEYS_ENABLED  - Enable additional control keys for CLI commands like ctrl+a, ctrl+e, ctrl+w, ctrl+u

#ifndef NRF_CLI_METAKEYS_ENABLED
#define NRF_CLI_METAKEYS_ENABLED 0
#endif

// <o> NRF_CLI_PRINTF_BUFF_SIZE - Maximum print buffer size.
#ifndef NRF_CLI_PRINTF_BUFF_SIZE
#define NRF_CLI_PRINTF_BUFF_SIZE 23
#endif

// <e> NRF_CLI_HISTORY_ENABLED - Enable CLI history mode.
//==========================================================
#ifndef NRF_CLI_HISTORY_ENABLED
#define NRF_CLI_HISTORY_ENABLED 1
#endif
// <o> NRF_CLI_HISTORY_ELEMENT_SIZE - Size of one memory object reserved for CLI history.
#ifndef NRF_CLI_HISTORY_ELEMENT_SIZE
#define NRF_CLI_HISTORY_ELEMENT_SIZE 32
#endif

// <o> NRF_CLI_HISTORY_ELEMENT_COUNT - Number of history memory objects.
#ifndef NRF_CLI_HISTORY_ELEMENT_COUNT
#define NRF_CLI_HISTORY_ELEMENT_COUNT 8
#endif

// </e>

// <q> NRF_CLI_VT100_COLORS_ENABLED  - CLI VT100 colors.

#ifndef NRF_CLI_VT100_COLORS_ENABLED
#define NRF_CLI_VT100_COLORS_ENABLED 1
#endif

// <q> NRF_CLI_STATISTICS_ENABLED  - Enable CLI statistics.

#ifndef NRF_CLI_STATISTICS_ENABLED
#define NRF_CLI_STATISTICS_ENABLED 1
#endif

// <q> NRF_CLI_LOG_BACKEND  - Enable logger backend interface.

#ifndef NRF_CLI_LOG_BACKEND
#define NRF_CLI_LOG_BACKEND 1
#endif

// <q> NRF_CLI_USES_TASK_MANAGER_ENABLED  - Enable CLI to use task_manager

#ifndef NRF_CLI_USES_TASK_MANAGER_ENABLED
#define NRF_CLI_USES_TASK_MANAGER_ENABLED 0
#endif

// <e> NRF_BALLOC_ENABLED - nrf_balloc - Block allocator module
//==========================================================
#ifndef NRF_BALLOC_ENABLED
#define NRF_BALLOC_ENABLED 1
#endif
// <e> NRF_BALLOC_CONFIG_DEBUG_ENABLED - Enables debug mode in the module.
//==========================================================
#ifndef NRF_BALLOC_CONFIG_DEBUG_ENABLED
#define NRF_BALLOC_CONFIG_DEBUG_ENABLED 0
#endif
// <o> NRF_BALLOC_CONFIG_HEAD_GUARD_WORDS - Number of words used as head guard.  <0-255>

#ifndef NRF_BALLOC_CONFIG_HEAD_GUARD_WORDS
#define NRF_BALLOC_CONFIG_HEAD_GUARD_WORDS 1
#endif

// <o> NRF_BALLOC_CONFIG_TAIL_GUARD_WORDS - Number of words used as tail guard.  <0-255>

#ifndef NRF_BALLOC_CONFIG_TAIL_GUARD_WORDS
#define NRF_BALLOC_CONFIG_TAIL_GUARD_WORDS 1
#endif

// <q> NRF_BALLOC_CONFIG_BASIC_CHECKS_ENABLED  - Enables basic checks in this module.

#ifndef NRF_BALLOC_CONFIG_BASIC_CHECKS_ENABLED
#define NRF_BALLOC_CONFIG_BASIC_CHECKS_ENABLED 0
#endif

// <q> NRF_BALLOC_CONFIG_DOUBLE_FREE_CHECK_ENABLED  - Enables double memory free check in this module.

#ifndef NRF_BALLOC_CONFIG_DOUBLE_FREE_CHECK_ENABLED
#define NRF_BALLOC_CONFIG_DOUBLE_FREE_CHECK_ENABLED 0
#endif

// <q> NRF_BALLOC_CONFIG_DATA_TRASHING_CHECK_ENABLED  - Enables free memory corruption check in this module.

#ifndef NRF_BALLOC_CONFIG_DATA_TRASHING_CHECK_ENABLED
#define NRF_BALLOC_CONFIG_DATA_TRASHING_CHECK_ENABLED 0
#endif

// <q> NRF_BALLOC_CLI_CMDS  - Enable CLI commands specific to the module

#ifndef NRF_BALLOC_CLI_CMDS
#define NRF_BALLOC_CLI_CMDS 0
#endif

// </e>

// </h>
//==========================================================

// <h> nrf_fprintf - fprintf function.

//==========================================================
// <q> NRF_FPRINTF_ENABLED  - Enable/disable fprintf module.

#ifndef NRF_FPRINTF_ENABLED
#define NRF_FPRINTF_ENABLED 1
#endif

// <q> NRF_FPRINTF_FLAG_AUTOMATIC_CR_ON_LF_ENABLED  - For each printed LF, function will add CR.

#ifndef NRF_FPRINTF_FLAG_AUTOMATIC_CR_ON_LF_ENABLED
#define NRF_FPRINTF_FLAG_AUTOMATIC_CR_ON_LF_ENABLED 1
#endif

// <e> NRF_QUEUE_ENABLED - nrf_queue - Queue module
//==========================================================
#ifndef NRF_QUEUE_ENABLED
#define NRF_QUEUE_ENABLED 1
#endif

// </e>

// <e> APP_TIMER_ENABLED - app_timer - Application timer functionality
//==========================================================
#ifndef APP_TIMER_ENABLED
#define APP_TIMER_ENABLED 1
#endif
// <o> APP_TIMER_CONFIG_RTC_FREQUENCY  - Configure RTC prescaler.

// <0=> 32768 Hz
// <1=> 16384 Hz
// <3=> 8192 Hz
// <7=> 4096 Hz
// <15=> 2048 Hz
// <31=> 1024 Hz

#ifndef APP_TIMER_CONFIG_RTC_FREQUENCY
#define APP_TIMER_CONFIG_RTC_FREQUENCY 1
#endif

// <o> APP_TIMER_CONFIG_IRQ_PRIORITY  - Interrupt priority

// <i> Priorities 0,2 (nRF51) and 0,1,4,5 (nRF52) are reserved for SoftDevice
// <0=> 0 (highest)
// <1=> 1
// <2=> 2
// <3=> 3
// <4=> 4
// <5=> 5
// <6=> 6
// <7=> 7

#ifndef APP_TIMER_CONFIG_IRQ_PRIORITY
#define APP_TIMER_CONFIG_IRQ_PRIORITY 6
#endif

// <o> APP_TIMER_CONFIG_OP_QUEUE_SIZE - Capacity of timer requests queue.
// <i> Size of the queue depends on how many timers are used
// <i> in the system, how often timers are started and overall
// <i> system latency. If queue size is too small app_timer calls
// <i> will fail.

#ifndef APP_TIMER_CONFIG_OP_QUEUE_SIZE
#define APP_TIMER_CONFIG_OP_QUEUE_SIZE 10
#endif

// <q> APP_TIMER_CONFIG_USE_SCHEDULER  - Enable scheduling app_timer events to app_scheduler

#ifndef APP_TIMER_CONFIG_USE_SCHEDULER
#define APP_TIMER_CONFIG_USE_SCHEDULER 0
#endif

// <q> APP_TIMER_KEEPS_RTC_ACTIVE  - Enable RTC always on

// <i> If option is enabled RTC is kept running even if there is no active timers.
// <i> This option can be used when app_timer is used for timestamping.

#ifndef APP_TIMER_KEEPS_RTC_ACTIVE
#define APP_TIMER_KEEPS_RTC_ACTIVE 0
#endif

// <o> APP_TIMER_SAFE_WINDOW_MS - Maximum possible latency (in milliseconds) of handling app_timer event.
// <i> Maximum possible timeout that can be set is reduced by safe window.
// <i> Example: RTC frequency 16384 Hz, maximum possible timeout 1024 seconds - APP_TIMER_SAFE_WINDOW_MS.
// <i> Since RTC is not stopped when processor is halted in debugging session, this value
// <i> must cover it if debugging is needed. It is possible to halt processor for APP_TIMER_SAFE_WINDOW_MS
// <i> without corrupting app_timer behavior.

#ifndef APP_TIMER_SAFE_WINDOW_MS
#define APP_TIMER_SAFE_WINDOW_MS 300000
#endif

// <h> App Timer Legacy configuration - Legacy configuration.

//==========================================================
// <q> APP_TIMER_WITH_PROFILER  - Enable app_timer profiling

#ifndef APP_TIMER_WITH_PROFILER
#define APP_TIMER_WITH_PROFILER 0
#endif

// <q> APP_TIMER_CONFIG_SWI_NUMBER  - Configure SWI instance used.

#ifndef APP_TIMER_CONFIG_SWI_NUMBER
#define APP_TIMER_CONFIG_SWI_NUMBER 0
#endif

#endif // SDK_CONFIG_H