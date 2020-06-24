#ifndef SDK_CONFIG_H
#define SDK_CONFIG_H

#ifndef NRF_LOG_ENABLED
#define NRF_LOG_ENABLED 0
#endif

// <e> NRFX_SPI_ENABLED - nrfx_spi - SPI peripheral driver
//==========================================================
#ifndef NRFX_SPI_ENABLED
#define NRFX_SPI_ENABLED 1
#endif
// <q> NRFX_SPI0_ENABLED  - Enable SPI0 instance

#ifndef NRFX_SPI0_ENABLED
#define NRFX_SPI0_ENABLED 1
#endif

// <q> NRFX_SPI1_ENABLED  - Enable SPI1 instance

#ifndef NRFX_SPI1_ENABLED
#define NRFX_SPI1_ENABLED 0
#endif

// <q> NRFX_SPI2_ENABLED  - Enable SPI2 instance

#ifndef NRFX_SPI2_ENABLED
#define NRFX_SPI2_ENABLED 0
#endif

// <o> NRFX_SPI_MISO_PULL_CFG  - MISO pin pull configuration.

// <0=> NRF_GPIO_PIN_NOPULL
// <1=> NRF_GPIO_PIN_PULLDOWN
// <3=> NRF_GPIO_PIN_PULLUP

#ifndef NRFX_SPI_MISO_PULL_CFG
#define NRFX_SPI_MISO_PULL_CFG 1
#endif

// <o> NRFX_SPI_DEFAULT_CONFIG_IRQ_PRIORITY  - Interrupt priority

// <0=> 0 (highest)
// <1=> 1
// <2=> 2
// <3=> 3
// <4=> 4
// <5=> 5
// <6=> 6
// <7=> 7

#ifndef NRFX_SPI_DEFAULT_CONFIG_IRQ_PRIORITY
#define NRFX_SPI_DEFAULT_CONFIG_IRQ_PRIORITY 6
#endif

// <e> NRFX_SPI_CONFIG_LOG_ENABLED - Enables logging in the module.
//==========================================================
#ifndef NRFX_SPI_CONFIG_LOG_ENABLED
#define NRFX_SPI_CONFIG_LOG_ENABLED 0
#endif
// <o> NRFX_SPI_CONFIG_LOG_LEVEL  - Default Severity level

// <0=> Off
// <1=> Error
// <2=> Warning
// <3=> Info
// <4=> Debug

#ifndef NRFX_SPI_CONFIG_LOG_LEVEL
#define NRFX_SPI_CONFIG_LOG_LEVEL 3
#endif

// <o> NRFX_SPI_CONFIG_INFO_COLOR  - ANSI escape code prefix.

// <0=> Default
// <1=> Black
// <2=> Red
// <3=> Green
// <4=> Yellow
// <5=> Blue
// <6=> Magenta
// <7=> Cyan
// <8=> White

#ifndef NRFX_SPI_CONFIG_INFO_COLOR
#define NRFX_SPI_CONFIG_INFO_COLOR 0
#endif

// <o> NRFX_SPI_CONFIG_DEBUG_COLOR  - ANSI escape code prefix.

// <0=> Default
// <1=> Black
// <2=> Red
// <3=> Green
// <4=> Yellow
// <5=> Blue
// <6=> Magenta
// <7=> Cyan
// <8=> White

#ifndef NRFX_SPI_CONFIG_DEBUG_COLOR
#define NRFX_SPI_CONFIG_DEBUG_COLOR 0
#endif

// </e>

// </e>

#endif // SDK_CONFIG_H