#ifndef SDK_CONFIG_H
#define SDK_CONFIG_H

#ifndef NRF_LOG_ENABLED
#define NRF_LOG_ENABLED 0
#endif

// <e> NRFX_SPIS_ENABLED - nrfx_spis - SPIS peripheral driver
//==========================================================
#ifndef NRFX_SPIS_ENABLED
#define NRFX_SPIS_ENABLED 1
#endif
// <q> NRFX_SPIS0_ENABLED  - Enable SPIS0 instance

#ifndef NRFX_SPIS0_ENABLED
#define NRFX_SPIS0_ENABLED 1
#endif

// <q> NRFX_SPIS1_ENABLED  - Enable SPIS1 instance

#ifndef NRFX_SPIS1_ENABLED
#define NRFX_SPIS1_ENABLED 0
#endif

// <q> NRFX_SPIS2_ENABLED  - Enable SPIS2 instance

#ifndef NRFX_SPIS2_ENABLED
#define NRFX_SPIS2_ENABLED 0
#endif

// <o> NRFX_SPIS_DEFAULT_CONFIG_IRQ_PRIORITY  - Interrupt priority

// <0=> 0 (highest)
// <1=> 1
// <2=> 2
// <3=> 3
// <4=> 4
// <5=> 5
// <6=> 6
// <7=> 7

#ifndef NRFX_SPIS_DEFAULT_CONFIG_IRQ_PRIORITY
#define NRFX_SPIS_DEFAULT_CONFIG_IRQ_PRIORITY 6
#endif

// <o> NRFX_SPIS_DEFAULT_DEF - SPIS default DEF character  <0-255>

#ifndef NRFX_SPIS_DEFAULT_DEF
#define NRFX_SPIS_DEFAULT_DEF 255
#endif

// <o> NRFX_SPIS_DEFAULT_ORC - SPIS default ORC character  <0-255>

#ifndef NRFX_SPIS_DEFAULT_ORC
#define NRFX_SPIS_DEFAULT_ORC 255
#endif

// <e> NRFX_SPIS_CONFIG_LOG_ENABLED - Enables logging in the module.
//==========================================================
#ifndef NRFX_SPIS_CONFIG_LOG_ENABLED
#define NRFX_SPIS_CONFIG_LOG_ENABLED 0
#endif
// <o> NRFX_SPIS_CONFIG_LOG_LEVEL  - Default Severity level

// <0=> Off
// <1=> Error
// <2=> Warning
// <3=> Info
// <4=> Debug

#ifndef NRFX_SPIS_CONFIG_LOG_LEVEL
#define NRFX_SPIS_CONFIG_LOG_LEVEL 3
#endif

// <o> NRFX_SPIS_CONFIG_INFO_COLOR  - ANSI escape code prefix.

// <0=> Default
// <1=> Black
// <2=> Red
// <3=> Green
// <4=> Yellow
// <5=> Blue
// <6=> Magenta
// <7=> Cyan
// <8=> White

#ifndef NRFX_SPIS_CONFIG_INFO_COLOR
#define NRFX_SPIS_CONFIG_INFO_COLOR 0
#endif

// <o> NRFX_SPIS_CONFIG_DEBUG_COLOR  - ANSI escape code prefix.

// <0=> Default
// <1=> Black
// <2=> Red
// <3=> Green
// <4=> Yellow
// <5=> Blue
// <6=> Magenta
// <7=> Cyan
// <8=> White

#ifndef NRFX_SPIS_CONFIG_DEBUG_COLOR
#define NRFX_SPIS_CONFIG_DEBUG_COLOR 0
#endif

// </e>

// <q> NRFX_SPIS_NRF52_ANOMALY_109_WORKAROUND_ENABLED  - Enables nRF52 Anomaly 109 workaround for SPIS.

// <i> The workaround uses a GPIOTE channel to generate interrupts
// <i> on falling edges detected on the CSN line. This will make
// <i> the CPU active for the moment when SPIS starts DMA transfers,
// <i> and this way the transfers will be protected.
// <i> This workaround uses GPIOTE driver, so this driver must be
// <i> enabled as well.

#ifndef NRFX_SPIS_NRF52_ANOMALY_109_WORKAROUND_ENABLED
#define NRFX_SPIS_NRF52_ANOMALY_109_WORKAROUND_ENABLED 0
#endif

// </e>

#endif // SDK_CONFIG_H