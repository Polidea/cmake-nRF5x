#ifndef SDK_CONFIG_H
#define SDK_CONFIG_H

#ifndef NRF_LOG_ENABLED
#define NRF_LOG_ENABLED 0
#endif

// <e> APP_USBD_ENABLED - app_usbd - USB Device library
//==========================================================
#ifndef APP_USBD_ENABLED
#define APP_USBD_ENABLED 1
#endif
// <o> APP_USBD_VID - Vendor ID.  <0x0000-0xFFFF>

// <i> Note: This value is not editable in Configuration Wizard.
// <i> Vendor ID ordered from USB IF: http://www.usb.org/developers/vendor/

#ifndef APP_USBD_VID
#define APP_USBD_VID 0
#endif

// <o> APP_USBD_PID - Product ID.  <0x0000-0xFFFF>

// <i> Note: This value is not editable in Configuration Wizard.
// <i> Selected Product ID

#ifndef APP_USBD_PID
#define APP_USBD_PID 0
#endif

// <o> APP_USBD_DEVICE_VER_MAJOR - Device version, major part.  <0-99>

// <i> Device version, will be converted automatically to BCD notation. Use just decimal values.

#ifndef APP_USBD_DEVICE_VER_MAJOR
#define APP_USBD_DEVICE_VER_MAJOR 1
#endif

// <o> APP_USBD_DEVICE_VER_MINOR - Device version, minor part.  <0-99>

// <i> Device version, will be converted automatically to BCD notation. Use just decimal values.

#ifndef APP_USBD_DEVICE_VER_MINOR
#define APP_USBD_DEVICE_VER_MINOR 0
#endif

// <q> APP_USBD_CONFIG_SELF_POWERED  - Self-powered device, as opposed to bus-powered.

#ifndef APP_USBD_CONFIG_SELF_POWERED
#define APP_USBD_CONFIG_SELF_POWERED 1
#endif

// <o> APP_USBD_CONFIG_MAX_POWER - MaxPower field in configuration descriptor in milliamps.  <0-500>

#ifndef APP_USBD_CONFIG_MAX_POWER
#define APP_USBD_CONFIG_MAX_POWER 100
#endif

// <q> APP_USBD_CONFIG_POWER_EVENTS_PROCESS  - Process power events.

// <i> Enable processing power events in USB event handler.

#ifndef APP_USBD_CONFIG_POWER_EVENTS_PROCESS
#define APP_USBD_CONFIG_POWER_EVENTS_PROCESS 1
#endif

// <e> APP_USBD_CONFIG_EVENT_QUEUE_ENABLE - Enable event queue.

// <i> This is the default configuration when all the events are placed into internal queue.
// <i> Disable it when an external queue is used like app_scheduler or if you wish to process all events inside interrupts.
// <i> Processing all events from the interrupt level adds requirement not to call any functions that modifies the USBD library state from the context higher than USB interrupt context.
// <i> Functions that modify USBD state are functions for sleep, wakeup, start, stop, enable, and disable.
//==========================================================
#ifndef APP_USBD_CONFIG_EVENT_QUEUE_ENABLE
#define APP_USBD_CONFIG_EVENT_QUEUE_ENABLE 1
#endif
// <o> APP_USBD_CONFIG_EVENT_QUEUE_SIZE - The size of the event queue.  <16-64>

// <i> The size of the queue for the events that would be processed in the main loop.

#ifndef APP_USBD_CONFIG_EVENT_QUEUE_SIZE
#define APP_USBD_CONFIG_EVENT_QUEUE_SIZE 32
#endif

// <o> APP_USBD_CONFIG_SOF_HANDLING_MODE  - Change SOF events handling mode.

// <i> Normal queue   - SOF events are pushed normally into the event queue.
// <i> Compress queue - SOF events are counted and binded with other events or executed when the queue is empty.
// <i>                  This prevents the queue from filling up with SOF events.
// <i> Interrupt      - SOF events are processed in interrupt.
// <0=> Normal queue
// <1=> Compress queue
// <2=> Interrupt

#ifndef APP_USBD_CONFIG_SOF_HANDLING_MODE
#define APP_USBD_CONFIG_SOF_HANDLING_MODE 1
#endif

// </e>

// <q> APP_USBD_CONFIG_SOF_TIMESTAMP_PROVIDE  - Provide a function that generates timestamps for logs based on the current SOF.

// <i> The function app_usbd_sof_timestamp_get is implemented if the logger is enabled.
// <i> Use it when initializing the logger.
// <i> SOF processing is always enabled when this configuration parameter is active.
// <i> Note: This option is configured outside of APP_USBD_CONFIG_LOG_ENABLED.
// <i> This means that it works even if the logging in this very module is disabled.

#ifndef APP_USBD_CONFIG_SOF_TIMESTAMP_PROVIDE
#define APP_USBD_CONFIG_SOF_TIMESTAMP_PROVIDE 0
#endif

// <o> APP_USBD_CONFIG_DESC_STRING_SIZE - Maximum size of the NULL-terminated string of the string descriptor.  <31-254>

// <i> 31 characters can be stored in the internal USB buffer used for transfers.
// <i> Any value higher than 31 creates an additional buffer just for descriptor strings.

#ifndef APP_USBD_CONFIG_DESC_STRING_SIZE
#define APP_USBD_CONFIG_DESC_STRING_SIZE 31
#endif

// <q> APP_USBD_CONFIG_DESC_STRING_UTF_ENABLED  - Enable UTF8 conversion.

// <i> Enable UTF8-encoded characters. In normal processing, only ASCII characters are available.

#ifndef APP_USBD_CONFIG_DESC_STRING_UTF_ENABLED
#define APP_USBD_CONFIG_DESC_STRING_UTF_ENABLED 0
#endif

// <s> APP_USBD_STRINGS_LANGIDS - Supported languages identifiers.

// <i> Note: This value is not editable in Configuration Wizard.
// <i> Comma-separated list of supported languages.
#ifndef APP_USBD_STRINGS_LANGIDS
#define APP_USBD_STRINGS_LANGIDS APP_USBD_LANG_AND_SUBLANG(APP_USBD_LANG_ENGLISH, APP_USBD_SUBLANG_ENGLISH_US)
#endif

// <e> APP_USBD_STRING_ID_MANUFACTURER - Define manufacturer string ID.

// <i> Setting ID to 0 disables the string.
//==========================================================
#ifndef APP_USBD_STRING_ID_MANUFACTURER
#define APP_USBD_STRING_ID_MANUFACTURER 1
#endif
// <q> APP_USBD_STRINGS_MANUFACTURER_EXTERN  - Define whether @ref APP_USBD_STRINGS_MANUFACTURER is created by macro or declared as a global variable.

#ifndef APP_USBD_STRINGS_MANUFACTURER_EXTERN
#define APP_USBD_STRINGS_MANUFACTURER_EXTERN 0
#endif

// <s> APP_USBD_STRINGS_MANUFACTURER - String descriptor for the manufacturer name.

// <i> Note: This value is not editable in Configuration Wizard.
// <i> Comma-separated list of manufacturer names for each defined language.
// <i> Use @ref APP_USBD_STRING_DESC macro to create string descriptor from a NULL-terminated string.
// <i> Use @ref APP_USBD_STRING_RAW8_DESC macro to create string descriptor from comma-separated uint8_t values.
// <i> Use @ref APP_USBD_STRING_RAW16_DESC macro to create string descriptor from comma-separated uint16_t values.
// <i> Alternatively, configure the macro to point to any internal variable pointer that already contains the descriptor.
// <i> Setting string to NULL disables that string.
// <i> The order of manufacturer names must be the same like in @ref APP_USBD_STRINGS_LANGIDS.
#ifndef APP_USBD_STRINGS_MANUFACTURER
#define APP_USBD_STRINGS_MANUFACTURER APP_USBD_STRING_DESC("Nordic Semiconductor")
#endif

// </e>

// <e> APP_USBD_STRING_ID_PRODUCT - Define product string ID.

// <i> Setting ID to 0 disables the string.
//==========================================================
#ifndef APP_USBD_STRING_ID_PRODUCT
#define APP_USBD_STRING_ID_PRODUCT 2
#endif
// <q> APP_USBD_STRINGS_PRODUCT_EXTERN  - Define whether @ref APP_USBD_STRINGS_PRODUCT is created by macro or declared as a global variable.

#ifndef APP_USBD_STRINGS_PRODUCT_EXTERN
#define APP_USBD_STRINGS_PRODUCT_EXTERN 0
#endif

// <s> APP_USBD_STRINGS_PRODUCT - String descriptor for the product name.

// <i> Note: This value is not editable in Configuration Wizard.
// <i> List of product names that is defined the same way like in @ref APP_USBD_STRINGS_MANUFACTURER.
#ifndef APP_USBD_STRINGS_PRODUCT
#define APP_USBD_STRINGS_PRODUCT APP_USBD_STRING_DESC("nRF52 USB Product")
#endif

// </e>

// <e> APP_USBD_STRING_ID_SERIAL - Define serial number string ID.

// <i> Setting ID to 0 disables the string.
//==========================================================
#ifndef APP_USBD_STRING_ID_SERIAL
#define APP_USBD_STRING_ID_SERIAL 3
#endif
// <q> APP_USBD_STRING_SERIAL_EXTERN  - Define whether @ref APP_USBD_STRING_SERIAL is created by macro or declared as a global variable.

#ifndef APP_USBD_STRING_SERIAL_EXTERN
#define APP_USBD_STRING_SERIAL_EXTERN 0
#endif

// <s> APP_USBD_STRING_SERIAL - String descriptor for the serial number.

// <i> Note: This value is not editable in Configuration Wizard.
// <i> Serial number that is defined the same way like in @ref APP_USBD_STRINGS_MANUFACTURER.
#ifndef APP_USBD_STRING_SERIAL
#define APP_USBD_STRING_SERIAL APP_USBD_STRING_DESC("000000000000")
#endif

// </e>

// <e> APP_USBD_STRING_ID_CONFIGURATION - Define configuration string ID.

// <i> Setting ID to 0 disables the string.
//==========================================================
#ifndef APP_USBD_STRING_ID_CONFIGURATION
#define APP_USBD_STRING_ID_CONFIGURATION 4
#endif
// <q> APP_USBD_STRING_CONFIGURATION_EXTERN  - Define whether @ref APP_USBD_STRINGS_CONFIGURATION is created by macro or declared as global variable.

#ifndef APP_USBD_STRING_CONFIGURATION_EXTERN
#define APP_USBD_STRING_CONFIGURATION_EXTERN 0
#endif

// <s> APP_USBD_STRINGS_CONFIGURATION - String descriptor for the device configuration.

// <i> Note: This value is not editable in Configuration Wizard.
// <i> Configuration string that is defined the same way like in @ref APP_USBD_STRINGS_MANUFACTURER.
#ifndef APP_USBD_STRINGS_CONFIGURATION
#define APP_USBD_STRINGS_CONFIGURATION APP_USBD_STRING_DESC("Default configuration")
#endif

// </e>

// <s> APP_USBD_STRINGS_USER - Default values for user strings.

// <i> Note: This value is not editable in Configuration Wizard.
// <i> This value stores all application specific user strings with the default initialization.
// <i> The setup is done by X-macros.
// <i> Expected macro parameters:
// <i> @code
// <i> X(mnemonic, [=str_idx], ...)
// <i> @endcode
// <i> - @c mnemonic: Mnemonic of the string descriptor that would be added to
// <i>                @ref app_usbd_string_desc_idx_t enumerator.
// <i> - @c str_idx : String index value, can be set or left empty.
// <i>                For example, WinUSB driver requires descriptor to be present on 0xEE index.
// <i>                Then use X(USBD_STRING_WINUSB, =0xEE, (APP_USBD_STRING_DESC(...)))
// <i> - @c ...     : List of string descriptors for each defined language.
#ifndef APP_USBD_STRINGS_USER
#define APP_USBD_STRINGS_USER X(APP_USER_1, , APP_USBD_STRING_DESC("User 1"))
#endif

// </e>

// <e> APP_USBD_HID_ENABLED - app_usbd_hid - USB HID class
//==========================================================
#ifndef APP_USBD_HID_ENABLED
#define APP_USBD_HID_ENABLED 1
#endif
// <o> APP_USBD_HID_DEFAULT_IDLE_RATE - Default idle rate for HID class.   <0-255>

// <i> 0 means indefinite duration, any other value is multiplied by 4 milliseconds. Refer to Chapter 7.2.4 of HID 1.11 Specification.

#ifndef APP_USBD_HID_DEFAULT_IDLE_RATE
#define APP_USBD_HID_DEFAULT_IDLE_RATE 0
#endif

// <o> APP_USBD_HID_REPORT_IDLE_TABLE_SIZE - Size of idle rate table.   <1-255>

// <i> Must be higher than the highest report ID used.

#ifndef APP_USBD_HID_REPORT_IDLE_TABLE_SIZE
#define APP_USBD_HID_REPORT_IDLE_TABLE_SIZE 4
#endif

// </e>

// <q> APP_USBD_HID_GENERIC_ENABLED  - app_usbd_hid_generic - USB HID generic

#ifndef APP_USBD_HID_GENERIC_ENABLED
#define APP_USBD_HID_GENERIC_ENABLED 0
#endif

// <q> APP_USBD_HID_KBD_ENABLED  - app_usbd_hid_kbd - USB HID keyboard

#ifndef APP_USBD_HID_KBD_ENABLED
#define APP_USBD_HID_KBD_ENABLED 1
#endif

// <q> APP_USBD_HID_MOUSE_ENABLED  - app_usbd_hid_mouse - USB HID mouse

#ifndef APP_USBD_HID_MOUSE_ENABLED
#define APP_USBD_HID_MOUSE_ENABLED 0
#endif

// <q> APP_USBD_MSC_ENABLED  - app_usbd_msc - USB MSC class

#ifndef APP_USBD_MSC_ENABLED
#define APP_USBD_MSC_ENABLED 0
#endif

// <e> APP_USBD_CONFIG_LOG_ENABLED - Enable logging in the module.
//==========================================================
#ifndef APP_USBD_CONFIG_LOG_ENABLED
#define APP_USBD_CONFIG_LOG_ENABLED 0
#endif

#ifndef APP_USBD_DEVICE_VER_SUB
#define APP_USBD_DEVICE_VER_SUB 0
#endif

// <e> NRFX_CLOCK_ENABLED - nrfx_clock - CLOCK peripheral driver
//==========================================================
#ifndef NRFX_CLOCK_ENABLED
#define NRFX_CLOCK_ENABLED 1
#endif
// <o> NRFX_CLOCK_CONFIG_LF_SRC  - LF Clock Source

// <0=> RC
// <1=> XTAL
// <2=> Synth
// <131073=> External Low Swing
// <196609=> External Full Swing

#ifndef NRFX_CLOCK_CONFIG_LF_SRC
#define NRFX_CLOCK_CONFIG_LF_SRC 1
#endif

// <o> NRFX_CLOCK_CONFIG_IRQ_PRIORITY  - Interrupt priority

// <0=> 0 (highest)
// <1=> 1
// <2=> 2
// <3=> 3
// <4=> 4
// <5=> 5
// <6=> 6
// <7=> 7

#ifndef NRFX_CLOCK_CONFIG_IRQ_PRIORITY
#define NRFX_CLOCK_CONFIG_IRQ_PRIORITY 6
#endif

// <e> NRFX_CLOCK_CONFIG_LOG_ENABLED - Enables logging in the module.
//==========================================================
#ifndef NRFX_CLOCK_CONFIG_LOG_ENABLED
#define NRFX_CLOCK_CONFIG_LOG_ENABLED 0
#endif
// <o> NRFX_CLOCK_CONFIG_LOG_LEVEL  - Default Severity level

// <0=> Off
// <1=> Error
// <2=> Warning
// <3=> Info
// <4=> Debug

#ifndef NRFX_CLOCK_CONFIG_LOG_LEVEL
#define NRFX_CLOCK_CONFIG_LOG_LEVEL 3
#endif

// <o> NRFX_CLOCK_CONFIG_INFO_COLOR  - ANSI escape code prefix.

// <0=> Default
// <1=> Black
// <2=> Red
// <3=> Green
// <4=> Yellow
// <5=> Blue
// <6=> Magenta
// <7=> Cyan
// <8=> White

#ifndef NRFX_CLOCK_CONFIG_INFO_COLOR
#define NRFX_CLOCK_CONFIG_INFO_COLOR 0
#endif

// <o> NRFX_CLOCK_CONFIG_DEBUG_COLOR  - ANSI escape code prefix.

// <0=> Default
// <1=> Black
// <2=> Red
// <3=> Green
// <4=> Yellow
// <5=> Blue
// <6=> Magenta
// <7=> Cyan
// <8=> White

#ifndef NRFX_CLOCK_CONFIG_DEBUG_COLOR
#define NRFX_CLOCK_CONFIG_DEBUG_COLOR 0
#endif

// </e>

// </e>

#ifndef NRFX_SYSTICK_ENABLED
#define NRFX_SYSTICK_ENABLED 1
#endif

// <e> NRFX_USBD_ENABLED - nrfx_usbd - USBD peripheral driver
//==========================================================
#ifndef NRFX_USBD_ENABLED
#define NRFX_USBD_ENABLED 1
#endif
// <o> NRFX_USBD_CONFIG_IRQ_PRIORITY  - Interrupt priority

// <0=> 0 (highest)
// <1=> 1
// <2=> 2
// <3=> 3
// <4=> 4
// <5=> 5
// <6=> 6
// <7=> 7

#ifndef NRFX_USBD_CONFIG_IRQ_PRIORITY
#define NRFX_USBD_CONFIG_IRQ_PRIORITY 7
#endif

// <q> USBD_CONFIG_DMASCHEDULER_ISO_BOOST  - Give priority to isochronous transfers

// <i> This option gives priority to isochronous transfers.
// <i> Enabling it assures that isochronous transfers are always processed,
// <i> even if multiple other transfers are pending.
// <i> Isochronous endpoints are prioritized before the usbd_dma_scheduler_algorithm
// <i> function is called, so the option is independent of the algorithm chosen.

#ifndef NRFX_USBD_CONFIG_DMASCHEDULER_ISO_BOOST
#define NRFX_USBD_CONFIG_DMASCHEDULER_ISO_BOOST 1
#endif

// <q> USBD_CONFIG_ISO_IN_ZLP  - Respond to an IN token on ISO IN endpoint with ZLP when no data is ready

// <i> If set, ISO IN endpoint will respond to an IN token with ZLP when no data is ready to be sent.
// <i> Else, there will be no response.

#ifndef NRFX_USBD_CONFIG_ISO_IN_ZLP
#define NRFX_USBD_CONFIG_ISO_IN_ZLP 0
#endif

// <e> NRFX_USBD_CONFIG_LOG_ENABLED - Enable logging in the module
//==========================================================
#ifndef NRFX_USBD_CONFIG_LOG_ENABLED
#define NRFX_USBD_CONFIG_LOG_ENABLED 0
#endif
// <o> NRFX_USBD_CONFIG_LOG_LEVEL  - Default Severity level

// <0=> Off
// <1=> Error
// <2=> Warning
// <3=> Info
// <4=> Debug

#ifndef NRFX_USBD_CONFIG_LOG_LEVEL
#define NRFX_USBD_CONFIG_LOG_LEVEL 3
#endif

// <o> NRFX_USBD_CONFIG_INFO_COLOR  - ANSI escape code prefix.

// <0=> Default
// <1=> Black
// <2=> Red
// <3=> Green
// <4=> Yellow
// <5=> Blue
// <6=> Magenta
// <7=> Cyan
// <8=> White

#ifndef NRFX_USBD_CONFIG_INFO_COLOR
#define NRFX_USBD_CONFIG_INFO_COLOR 0
#endif

// <o> NRFX_USBD_CONFIG_DEBUG_COLOR  - ANSI escape code prefix.

// <0=> Default
// <1=> Black
// <2=> Red
// <3=> Green
// <4=> Yellow
// <5=> Blue
// <6=> Magenta
// <7=> Cyan
// <8=> White

#ifndef NRFX_USBD_CONFIG_DEBUG_COLOR
#define NRFX_USBD_CONFIG_DEBUG_COLOR 0
#endif

// </e>

// </e>

// <e> USBD_ENABLED - nrf_drv_usbd - Software Component
//==========================================================
#ifndef USBD_ENABLED
#define USBD_ENABLED 1
#endif
// <o> USBD_CONFIG_IRQ_PRIORITY  - Interrupt priority

// <i> Priorities 0,2 (nRF51) and 0,1,4,5 (nRF52) are reserved for SoftDevice
// <0=> 0 (highest)
// <1=> 1
// <2=> 2
// <3=> 3
// <4=> 4
// <5=> 5
// <6=> 6
// <7=> 7

#ifndef USBD_CONFIG_IRQ_PRIORITY
#define USBD_CONFIG_IRQ_PRIORITY 6
#endif

// <o> USBD_CONFIG_DMASCHEDULER_MODE  - USBD SMA scheduler working scheme

// <0=> Prioritized access
// <1=> Round Robin

#ifndef USBD_CONFIG_DMASCHEDULER_MODE
#define USBD_CONFIG_DMASCHEDULER_MODE 0
#endif

// <q> USBD_CONFIG_DMASCHEDULER_ISO_BOOST  - Give priority to isochronous transfers

// <i> This option gives priority to isochronous transfers.
// <i> Enabling it assures that isochronous transfers are always processed,
// <i> even if multiple other transfers are pending.
// <i> Isochronous endpoints are prioritized before the usbd_dma_scheduler_algorithm
// <i> function is called, so the option is independent of the algorithm chosen.

#ifndef USBD_CONFIG_DMASCHEDULER_ISO_BOOST
#define USBD_CONFIG_DMASCHEDULER_ISO_BOOST 1
#endif

// <q> USBD_CONFIG_ISO_IN_ZLP  - Respond to an IN token on ISO IN endpoint with ZLP when no data is ready

// <i> If set, ISO IN endpoint will respond to an IN token with ZLP when no data is ready to be sent.
// <i> Else, there will be no response.
// <i> NOTE: This option does not work on Engineering A chip.

#ifndef USBD_CONFIG_ISO_IN_ZLP
#define USBD_CONFIG_ISO_IN_ZLP 0
#endif

// <e> POWER_ENABLED - nrf_drv_power - POWER peripheral driver - legacy layer
//==========================================================
#ifndef POWER_ENABLED
#define POWER_ENABLED 1
#endif
// <o> POWER_CONFIG_IRQ_PRIORITY  - Interrupt priority

// <i> Priorities 0,2 (nRF51) and 0,1,4,5 (nRF52) are reserved for SoftDevice
// <0=> 0 (highest)
// <1=> 1
// <2=> 2
// <3=> 3
// <4=> 4
// <5=> 5
// <6=> 6
// <7=> 7

#ifndef POWER_CONFIG_IRQ_PRIORITY
#define POWER_CONFIG_IRQ_PRIORITY 6
#endif

// <q> POWER_CONFIG_DEFAULT_DCDCEN  - The default configuration of main DCDC regulator

// <i> This settings means only that components for DCDC regulator are installed and it can be enabled.

#ifndef POWER_CONFIG_DEFAULT_DCDCEN
#define POWER_CONFIG_DEFAULT_DCDCEN 0
#endif

// <q> POWER_CONFIG_DEFAULT_DCDCENHV  - The default configuration of High Voltage DCDC regulator

// <i> This settings means only that components for DCDC regulator are installed and it can be enabled.

#ifndef POWER_CONFIG_DEFAULT_DCDCENHV
#define POWER_CONFIG_DEFAULT_DCDCENHV 0
#endif

// </e>

// <e> NRFX_POWER_ENABLED - nrfx_power - POWER peripheral driver
//==========================================================
#ifndef NRFX_POWER_ENABLED
#define NRFX_POWER_ENABLED 1
#endif
// <o> NRFX_POWER_CONFIG_IRQ_PRIORITY  - Interrupt priority

// <0=> 0 (highest)
// <1=> 1
// <2=> 2
// <3=> 3
// <4=> 4
// <5=> 5
// <6=> 6
// <7=> 7

#ifndef NRFX_POWER_CONFIG_IRQ_PRIORITY
#define NRFX_POWER_CONFIG_IRQ_PRIORITY 6
#endif

// <q> NRFX_POWER_CONFIG_DEFAULT_DCDCEN  - The default configuration of main DCDC regulator

// <i> This settings means only that components for DCDC regulator are installed and it can be enabled.

#ifndef NRFX_POWER_CONFIG_DEFAULT_DCDCEN
#define NRFX_POWER_CONFIG_DEFAULT_DCDCEN 0
#endif

// <q> NRFX_POWER_CONFIG_DEFAULT_DCDCENHV  - The default configuration of High Voltage DCDC regulator

// <i> This settings means only that components for DCDC regulator are installed and it can be enabled.

#ifndef NRFX_POWER_CONFIG_DEFAULT_DCDCENHV
#define NRFX_POWER_CONFIG_DEFAULT_DCDCENHV 0
#endif

// </e>

// <e> NRF_SDH_SOC_ENABLED - nrf_sdh_soc - SoftDevice SoC event handler
//==========================================================
#ifndef NRF_SDH_SOC_ENABLED
#define NRF_SDH_SOC_ENABLED 1
#endif
// <h> SoC Observers - Observers and priority levels

//==========================================================
// <o> NRF_SDH_SOC_OBSERVER_PRIO_LEVELS - Total number of priority levels for SoC observers.
// <i> This setting configures the number of priority levels available for the SoC event handlers.
// <i> The priority level of a handler determines the order in which it receives events, with respect to other handlers.

#ifndef NRF_SDH_SOC_OBSERVER_PRIO_LEVELS
#define NRF_SDH_SOC_OBSERVER_PRIO_LEVELS 2
#endif

// <h> State Observers priorities - Invididual priorities

//==========================================================
// <o> CLOCK_CONFIG_STATE_OBSERVER_PRIO
// <i> Priority with which state events are dispatched to the Clock driver.

#ifndef CLOCK_CONFIG_STATE_OBSERVER_PRIO
#define CLOCK_CONFIG_STATE_OBSERVER_PRIO 0
#endif

// <o> CLOCK_CONFIG_SOC_OBSERVER_PRIO
// <i> Priority with which SoC events are dispatched to the Clock driver.

#ifndef CLOCK_CONFIG_SOC_OBSERVER_PRIO
#define CLOCK_CONFIG_SOC_OBSERVER_PRIO 0
#endif

// <o> NRF_SDH_SOC_STACK_OBSERVER_PRIO
// <i> This setting configures the priority with which SoC events are processed with respect to other events coming from the stack.
// <i> Modify this setting if you need to have SoC events dispatched before or after other stack events, such as ANT or BLE.
// <i> Zero is the highest priority.

#ifndef NRF_SDH_SOC_STACK_OBSERVER_PRIO
#define NRF_SDH_SOC_STACK_OBSERVER_PRIO 0
#endif

#ifndef NRF_SDH_STATE_OBSERVER_PRIO_LEVELS
#define NRF_SDH_STATE_OBSERVER_PRIO_LEVELS 2
#endif

#ifndef NRF_SDH_STACK_OBSERVER_PRIO_LEVELS
#define NRF_SDH_STACK_OBSERVER_PRIO_LEVELS 2
#endif

// <o> POWER_CONFIG_SOC_OBSERVER_PRIO
// <i> Priority with which SoC events are dispatched to the Power driver.

#ifndef POWER_CONFIG_SOC_OBSERVER_PRIO
#define POWER_CONFIG_SOC_OBSERVER_PRIO 0
#endif

// <e> NRF_SDH_ENABLED - nrf_sdh - SoftDevice handler
//==========================================================
#ifndef NRF_SDH_ENABLED
#define NRF_SDH_ENABLED 1
#endif

// </h>
//==========================================================

// <h> Clock - SoftDevice clock configuration

//==========================================================
// <o> NRF_SDH_CLOCK_LF_SRC  - SoftDevice clock source.

// <0=> NRF_CLOCK_LF_SRC_RC
// <1=> NRF_CLOCK_LF_SRC_XTAL
// <2=> NRF_CLOCK_LF_SRC_SYNTH

#ifndef NRF_SDH_CLOCK_LF_SRC
#define NRF_SDH_CLOCK_LF_SRC 1
#endif

// <o> NRF_SDH_CLOCK_LF_RC_CTIV - SoftDevice calibration timer interval.
#ifndef NRF_SDH_CLOCK_LF_RC_CTIV
#define NRF_SDH_CLOCK_LF_RC_CTIV 0
#endif

// <o> NRF_SDH_CLOCK_LF_RC_TEMP_CTIV - SoftDevice calibration timer interval under constant temperature.
// <i> How often (in number of calibration intervals) the RC oscillator shall be calibrated
// <i>  if the temperature has not changed.

#ifndef NRF_SDH_CLOCK_LF_RC_TEMP_CTIV
#define NRF_SDH_CLOCK_LF_RC_TEMP_CTIV 0
#endif

// <o> NRF_SDH_CLOCK_LF_ACCURACY  - External clock accuracy used in the LL to compute timing.

// <0=> NRF_CLOCK_LF_ACCURACY_250_PPM
// <1=> NRF_CLOCK_LF_ACCURACY_500_PPM
// <2=> NRF_CLOCK_LF_ACCURACY_150_PPM
// <3=> NRF_CLOCK_LF_ACCURACY_100_PPM
// <4=> NRF_CLOCK_LF_ACCURACY_75_PPM
// <5=> NRF_CLOCK_LF_ACCURACY_50_PPM
// <6=> NRF_CLOCK_LF_ACCURACY_30_PPM
// <7=> NRF_CLOCK_LF_ACCURACY_20_PPM
// <8=> NRF_CLOCK_LF_ACCURACY_10_PPM
// <9=> NRF_CLOCK_LF_ACCURACY_5_PPM
// <10=> NRF_CLOCK_LF_ACCURACY_2_PPM
// <11=> NRF_CLOCK_LF_ACCURACY_1_PPM

#ifndef NRF_SDH_CLOCK_LF_ACCURACY
#define NRF_SDH_CLOCK_LF_ACCURACY 7
#endif

// </e>
// <q> NRF_SECTION_ITER_ENABLED  - nrf_section_iter - Section iterator

#ifndef NRF_SECTION_ITER_ENABLED
#define NRF_SECTION_ITER_ENABLED 1
#endif

#ifndef POWER_CONFIG_STATE_OBSERVER_PRIO
#define POWER_CONFIG_STATE_OBSERVER_PRIO 0
#endif

#ifndef CLOCK_CONFIG_IRQ_PRIORITY
#define CLOCK_CONFIG_IRQ_PRIORITY 6
#endif

// <e> NRF_CLOCK_ENABLED - nrf_drv_clock - CLOCK peripheral driver - legacy layer
//==========================================================
#ifndef NRF_CLOCK_ENABLED
#define NRF_CLOCK_ENABLED 1
#endif
// <o> CLOCK_CONFIG_LF_SRC  - LF Clock Source

// <0=> RC
// <1=> XTAL
// <2=> Synth
// <131073=> External Low Swing
// <196609=> External Full Swing

#ifndef CLOCK_CONFIG_LF_SRC
#define CLOCK_CONFIG_LF_SRC 1
#endif

// <q> CLOCK_CONFIG_LF_CAL_ENABLED  - Calibration enable for LF Clock Source

#ifndef CLOCK_CONFIG_LF_CAL_ENABLED
#define CLOCK_CONFIG_LF_CAL_ENABLED 0
#endif

// <o> CLOCK_CONFIG_IRQ_PRIORITY  - Interrupt priority

// <i> Priorities 0,2 (nRF51) and 0,1,4,5 (nRF52) are reserved for SoftDevice
// <0=> 0 (highest)
// <1=> 1
// <2=> 2
// <3=> 3
// <4=> 4
// <5=> 5
// <6=> 6
// <7=> 7

#ifndef CLOCK_CONFIG_IRQ_PRIORITY
#define CLOCK_CONFIG_IRQ_PRIORITY 6
#endif

#endif // SDK_CONFIG_H