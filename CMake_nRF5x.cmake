cmake_minimum_required(VERSION 3.6)

# check if all the necessary tools paths have been provided.
if (NOT NRF5_SDK_PATH)
    message(FATAL_ERROR "The path to the nRF5 SDK (NRF5_SDK_PATH) must be set.")
endif ()

if (NOT NRFJPROG)
    message(FATAL_ERROR "The path to the nrfjprog utility (NRFJPROG) must be set.")
endif ()

# convert toolchain path to bin path
if(DEFINED ARM_NONE_EABI_TOOLCHAIN_PATH)
    set(ARM_NONE_EABI_TOOLCHAIN_BIN_PATH ${ARM_NONE_EABI_TOOLCHAIN_PATH}/bin)
endif()

# check if the nRF target has been set
if (NRF_TARGET MATCHES "nrf51")

elseif (NRF_TARGET MATCHES "nrf52")

elseif (NOT NRF_TARGET)
    message(FATAL_ERROR "NRF_TARGET must be defined")
else ()
    message(FATAL_ERROR "NRF_TARGET: only nRF51 and rRF52 boards are supported right now")
endif ()

if(NOT DEFINED NRF_SOFTDEVICE)
    message(FATAL_ERROR "NRF_SOFTDEVICE must be defined")
endif()

message(NRF\ CONFIG \n--\ Board:\ ${NRF_TARGET}\ ${NRF_BOARD}\n--\ Softdevice:\ ${NRF_SOFTDEVICE}\n--\ Path:\ ${PROJECT_PATH}\n--
         \ Config:\ ${NRF_CONFIG}\n--\ Linker:\ ${NRF5_LINKER_SCRIPT}\n=======)

# must be set in file (not macro) scope (in macro would point to parent CMake directory)
set(DIR_OF_nRF5_CMAKE ${CMAKE_CURRENT_LIST_DIR})

macro(nRF5_toolchainSetup)
    include(${DIR_OF_nRF5_CMAKE}/arm-gcc-toolchain.cmake)
endmacro()

macro(nRF5_setup)
    if(NOT DEFINED ARM_GCC_TOOLCHAIN)
        message(FATAL_ERROR "The toolchain must be set up before calling this macro")
    endif()
    # fix on macOS: prevent cmake from adding implicit parameters to Xcode
    set(CMAKE_OSX_SYSROOT "/")
    set(CMAKE_OSX_DEPLOYMENT_TARGET "")

    # language standard/version settings
    set(CMAKE_C_STANDARD 99)
    set(CMAKE_CXX_STANDARD 98)

    # CPU specyfic settings
    if (NRF_TARGET MATCHES "nrf51")
        # nRF51 (nRF51-DK => PCA10028)
        if(NOT DEFINED NRF5_LINKER_SCRIPT)
            set(NRF5_LINKER_SCRIPT "${CMAKE_SOURCE_DIR}/gcc_nrf51.ld")
        endif()
        set(CPU_FLAGS "-mcpu=cortex-m0 -g3 -mfloat-abi=soft -MP -MD -mthumb -mabi=aapcs -Wall -g3 -ffunction-sections -fdata-sections -fno-strict-aliasing -fno-builtin --short-enums")
        add_definitions(-DBOARD_PCA10028 -DNRF51 -DNRF51422)
        if(DEFINED NRF_SOFTDEVICE_PATH AND DEFINED NRF_SOFTDEVICE)
            add_definitions(-DSOFTDEVICE_PRESENT -D${NRF_SOFTDEVICE} -DNRF_SD_BLE_API_VERSION=2 -DSWI_DISABLE0 -DBLE_STACK_SUPPORT_REQD)
            include_directories(
                    "${NRF5_SDK_PATH}/components/softdevice/${NRF_SOFTDEVICE}/headers"
                    "${NRF5_SDK_PATH}/components/softdevice/${NRF_SOFTDEVICE}/headers/nrf51"
            )
        endif()
        list(APPEND SDK_SOURCE_FILES
                "${NRF5_SDK_PATH}/modules/nrfx/mdk/system_nrf51.c"
                "${NRF5_SDK_PATH}/modules/nrfx/mdk/gcc_startup_nrf51.S"
                )
        if(NOT CPU_FLAGS)
            message(FATAL_ERROR "Please define NRF_BOARD with one of [pca10028]")
        endif()

    elseif (NRF_TARGET MATCHES "nrf52")
        if(NOT DEFINED NRF5_LINKER_SCRIPT)
            set(NRF5_LINKER_SCRIPT "${CMAKE_SOURCE_DIR}/gcc_nrf52.ld")
        endif()
        if(NOT DEFINED HEAP_SIZE OR NOT DEFINED STACK_SIZE)
            if(NRF_BOARD MATCHES "pca10056e" OR NRF_BOARD MATCHES "pca10040e")
                add_definitions(-D__HEAP_SIZE=0 -D__STACK_SIZE=2048)
            else()
                add_definitions(-D__HEAP_SIZE=0 -D__STACK_SIZE=8192)
            endif()
        else()
            add_definitions(-D__HEAP_SIZE=${HEAP_SIZE} -D__STACK_SIZE=${STACK_SIZE})
        endif()
        if(NRF_BOARD MATCHES "pca10040")
            set(CPU_FLAGS "-mcpu=cortex-m4 -mthumb -mabi=aapcs -Wall -Werror -mfloat-abi=hard -mfpu=fpv4-sp-d16 -ffunction-sections -fdata-sections -fno-strict-aliasing -fno-builtin -fshort-enums")
            add_definitions(-DBOARD_PCA10040 -DCONFIG_GPIO_AS_PINRESET -DFLOAT_ABI_HARD -DNRF52832_XXAA)
        elseif(NRF_BOARD MATCHES "pca10040e")
            set(CPU_FLAGS "-mcpu=cortex-m4 -mthumb -mabi=aapcs -Wall -Werror -mfloat-abi=soft -ffunction-sections -fdata-sections -fno-strict-aliasing -fno-builtin -fshort-enums")
            add_definitions(-DBOARD_PCA10040 -DCONFIG_GPIO_AS_PINRESET -DDEVELOP_IN_NRF52832 -DFLOAT_ABI_SOFT -DNRF52810_XXAA -DNRFX_COREDEP_DELAY_US_LOOP_CYCLES=3 )
        elseif(NRF_BOARD MATCHES "pca10056")
            set(CPU_FLAGS "-mcpu=cortex-m4 -mthumb -mabi=aapcs -Wall -Werror -mfloat-abi=hard -mfpu=fpv4-sp-d16 -ffunction-sections -fdata-sections -fno-strict-aliasing -fno-builtin -fshort-enums")
            add_definitions(-DBOARD_PCA10056 -DCONFIG_GPIO_AS_PINRESET -DFLOAT_ABI_HARD -DNRF52840_XXAA)
            if(DEFINED CRYPTOCELL)
                add_definitions(-DDX_CC_TEE -DECC_INTEGTEST -DNRF_SDK_PRESENT)
            endif()
        elseif(NRF_BOARD MATCHES "pca10056e")
            set(CPU_FLAGS "-mcpu=cortex-m4 -mthumb -mabi=aapcs -Wall -Werror -mfloat-abi=soft -ffunction-sections -fdata-sections -fno-strict-aliasing -fno-builtin -fshort-enums")
            add_definitions(-DBOARD_PCA10056 -DCONFIG_GPIO_AS_PINRESET -DDEVELOP_IN_NRF52840 -DFLOAT_ABI_SOFT -DNRF52811_XXAA -DNRFX_COREDEP_DELAY_US_LOOP_CYCLES=3)
            add_definitions(-D__HEAP_SIZE=2048 -D__STACK_SIZE=2048)
        elseif(NRF_BOARD MATCHES "pca10059")
            set(CPU_FLAGS "-mcpu=cortex-m4 -mthumb -mabi=aapcs -Wall -Werror -mfloat-abi=hard -mfpu=fpv4-sp-d16 -ffunction-sections -fdata-sections -fno-strict-aliasing -fno-builtin -fshort-enums")
            add_definitions(-DBOARD_PCA10059 -DCONFIG_GPIO_AS_PINRESET -DFLOAT_ABI_HARD -DMBR_PRESENT -DNRF52840_XXAA)
            add_definitions(-D__HEAP_SIZE=8192 -D__STACK_SIZE=8192)
        endif()
        if(NOT CPU_FLAGS)
            message(FATAL_ERROR "Please define NRF_BOARD with one of [pca10040, pca10056, pca10040e, pca10056e, pca10059]")
        endif()
        if(NOT NRF_SOFTDEVICE MATCHES "mbr")
            include_directories(
                    "${NRF5_SDK_PATH}/components/softdevice/${NRF_SOFTDEVICE}/headers"
                    "${NRF5_SDK_PATH}/components/softdevice/${NRF_SOFTDEVICE}/headers/nrf52"
            )
        else()
            # TODO: Add flash mbr command
            include_directories(
                    "${NRF5_SDK_PATH}/components/softdevice/${NRF_SOFTDEVICE}/${NRF_MODEL}/headers"
            )
        endif()
#        include_directories(
#                "${NRF5_SDK_PATH}/config/${NRF_MODEL}/config"
#        )
        list(APPEND SDK_SOURCE_FILES
                "${NRF5_SDK_PATH}/modules/nrfx/mdk/gcc_startup_nrf52.S"
                "${NRF5_SDK_PATH}/modules/nrfx/mdk/system_nrf52.c"
        )
        if(DEFINED NRF_SOFTDEVICE_PATH)
            add_definitions(-DSOFTDEVICE_PRESENT -DS${NRF_SOFTDEVICE} -DSWI_DISABLE0 -DBLE_STACK_SUPPORT_REQD -DNRF_SD_BLE_API_VERSION=6)
        endif()
    endif ()

# compiler/assambler/linker flags
    set(CMAKE_C_FLAGS "${CPU_FLAGS}")
    set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -O1")
    set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -O3")
    set(CMAKE_CXX_FLAGS "${CPU_FLAGS}")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -O1")
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3")
    set(CMAKE_ASM_FLAGS "-MP -MD -std=c99 -x assembler-with-cpp -g3 ${CPU_FLAGS}")
    set(CMAKE_EXE_LINKER_FLAGS "-mthumb -mabi=aapcs -std=gnu++98 -std=c99 -L ${NRF5_SDK_PATH}/modules/nrfx/mdk -T${NRF5_LINKER_SCRIPT} ${CPU_FLAGS} -Wl,--gc-sections --specs=nano.specs -lc -lnosys -lm")
    # note: we must override the default cmake linker flags so that CMAKE_C_FLAGS are not added implicitly
    set(CMAKE_C_LINK_EXECUTABLE "${CMAKE_C_COMPILER} <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
    set(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_C_COMPILER} <LINK_FLAGS> <OBJECTS> -lstdc++ -o <TARGET> <LINK_LIBRARIES>")

    # basic board definitions and drivers
    include_directories(
            "${NRF5_SDK_PATH}/components"
            "${NRF5_SDK_PATH}/components/boards"
            "${NRF5_SDK_PATH}/components/softdevice/common"
            "${NRF5_SDK_PATH}/components/drivers_nrf/nrf_soc_nosd"
            "${NRF5_SDK_PATH}/modules/nrfx"
            "${NRF5_SDK_PATH}/modules/nrfx/hal"
            "${NRF5_SDK_PATH}/modules/nrfx/mdk"
            "${NRF5_SDK_PATH}/modules/nrfx/drivers/"
            "${NRF5_SDK_PATH}/modules/nrfx/drivers/include"
            "${NRF5_SDK_PATH}/integration/nrfx"
            "${NRF5_SDK_PATH}/integration/nrfx/legacy"
    )

    list(APPEND SDK_SOURCE_FILES
            "${NRF5_SDK_PATH}/components/boards/boards.c"
            "${NRF5_SDK_PATH}/components/softdevice/common/nrf_sdh.c"
            "${NRF5_SDK_PATH}/components/softdevice/common/nrf_sdh_soc.c"
            "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_clock.c"
            "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_gpiote.c"
            "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_uart.c"
            "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_uarte.c"
            "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_power.c"
            "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/prs/nrfx_prs.c"
            "${NRF5_SDK_PATH}/modules/nrfx/soc/nrfx_atomic.c"
    )

    # toolchain specific
    include_directories(
            "${NRF5_SDK_PATH}/components/toolchain/cmsis/include"
    )

    # libraries
    include_directories(
            "${NRF5_SDK_PATH}/components/libraries/atomic"
            "${NRF5_SDK_PATH}/components/libraries/atomic_fifo"
            "${NRF5_SDK_PATH}/components/libraries/atomic_flags"
            "${NRF5_SDK_PATH}/components/libraries/balloc"
            "${NRF5_SDK_PATH}/components/libraries/bootloader/ble_dfu"
            "${NRF5_SDK_PATH}/components/libraries/cli"
            "${NRF5_SDK_PATH}/components/libraries/cli/libuarte"
            "${NRF5_SDK_PATH}/components/libraries/crc16"
            "${NRF5_SDK_PATH}/components/libraries/crc32"
            "${NRF5_SDK_PATH}/components/libraries/crypto"
            "${NRF5_SDK_PATH}/components/libraries/csense"
            "${NRF5_SDK_PATH}/components/libraries/csense_drv"
            "${NRF5_SDK_PATH}/components/libraries/delay"
            "${NRF5_SDK_PATH}/components/libraries/ecc"
            "${NRF5_SDK_PATH}/components/libraries/experimental_section_vars"
            "${NRF5_SDK_PATH}/components/libraries/experimental_task_manager"
            "${NRF5_SDK_PATH}/components/libraries/fds"
            "${NRF5_SDK_PATH}/components/libraries/fstorage"
            "${NRF5_SDK_PATH}/components/libraries/gfx"
            "${NRF5_SDK_PATH}/components/libraries/gpiote"
            "${NRF5_SDK_PATH}/components/libraries/hardfault"
            "${NRF5_SDK_PATH}/components/libraries/hardfault/${NRF_TARGET}"
            "${NRF5_SDK_PATH}/components/libraries/hci"
            "${NRF5_SDK_PATH}/components/libraries/led_softblink"
            "${NRF5_SDK_PATH}/components/libraries/libuarte"
            "${NRF5_SDK_PATH}/components/libraries/log"
            "${NRF5_SDK_PATH}/components/libraries/log/src"
            "${NRF5_SDK_PATH}/components/libraries/low_power_pwm"
            "${NRF5_SDK_PATH}/components/libraries/mem_manager"
            "${NRF5_SDK_PATH}/components/libraries/memobj"
            "${NRF5_SDK_PATH}/components/libraries/mpu"
            "${NRF5_SDK_PATH}/components/libraries/mutex"
            "${NRF5_SDK_PATH}/components/libraries/pwm"
            "${NRF5_SDK_PATH}/components/libraries/pwr_mgmt"
            "${NRF5_SDK_PATH}/components/libraries/queue"
            "${NRF5_SDK_PATH}/components/libraries/ringbuf"
            "${NRF5_SDK_PATH}/components/libraries/scheduler"
            "${NRF5_SDK_PATH}/components/libraries/sdcard"
            "${NRF5_SDK_PATH}/components/libraries/slip"
            "${NRF5_SDK_PATH}/components/libraries/sortlist"
            "${NRF5_SDK_PATH}/components/libraries/spi_mngr"
            "${NRF5_SDK_PATH}/components/libraries/stack_guard"
            "${NRF5_SDK_PATH}/components/libraries/strerror"
            "${NRF5_SDK_PATH}/components/libraries/svc"
            "${NRF5_SDK_PATH}/components/libraries/timer"
            "${NRF5_SDK_PATH}/components/libraries/twi_mngr"
            "${NRF5_SDK_PATH}/components/libraries/twi_sensor"
            "${NRF5_SDK_PATH}/components/libraries/queue/"
            "${NRF5_SDK_PATH}/components/libraries/uart"
            "${NRF5_SDK_PATH}/components/libraries/usbd"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/audio"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/cdc"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/cdc/acm"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/hid"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/hid/generic"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/hid/kbd"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/hid/mouse"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/msc"
            "${NRF5_SDK_PATH}/components/libraries/util"
    )

    list(APPEND SDK_SOURCE_FILES
            "${NRF5_SDK_PATH}/components/libraries/atomic/nrf_atomic.c"
            "${NRF5_SDK_PATH}/components/libraries/atomic_fifo/nrf_atfifo.c"
            "${NRF5_SDK_PATH}/components/libraries/atomic_flags/nrf_atflags.c"
            "${NRF5_SDK_PATH}/components/libraries/balloc/nrf_balloc.c"
            "${NRF5_SDK_PATH}/components/libraries/experimental_section_vars/nrf_section_iter.c"
            "${NRF5_SDK_PATH}/components/libraries/hardfault/hardfault_implementation.c"
            "${NRF5_SDK_PATH}/components/libraries/log/src/nrf_log_backend_flash.c"
            "${NRF5_SDK_PATH}/components/libraries/log/src/nrf_log_backend_rtt.c"
            "${NRF5_SDK_PATH}/components/libraries/log/src/nrf_log_backend_serial.c"
            "${NRF5_SDK_PATH}/components/libraries/log/src/nrf_log_backend_uart.c"
            "${NRF5_SDK_PATH}/components/libraries/log/src/nrf_log_default_backends.c"
            "${NRF5_SDK_PATH}/components/libraries/log/src/nrf_log_frontend.c"
            "${NRF5_SDK_PATH}/components/libraries/log/src/nrf_log_str_formatter.c"
            "${NRF5_SDK_PATH}/components/libraries/memobj/nrf_memobj.c"
            "${NRF5_SDK_PATH}/components/libraries/pwr_mgmt/nrf_pwr_mgmt.c"
            "${NRF5_SDK_PATH}/components/libraries/ringbuf/nrf_ringbuf.c"
            "${NRF5_SDK_PATH}/components/libraries/strerror/nrf_strerror.c"
            "${NRF5_SDK_PATH}/components/libraries/stack_guard/nrf_stack_guard.c"
            "${NRF5_SDK_PATH}/components/libraries/queue/nrf_queue.c"
            "${NRF5_SDK_PATH}/components/libraries/uart/retarget.c"
            "${NRF5_SDK_PATH}/components/libraries/util/nrf_assert.c"
            "${NRF5_SDK_PATH}/components/libraries/util/app_error.c"
            "${NRF5_SDK_PATH}/components/libraries/util/app_error_weak.c"
            "${NRF5_SDK_PATH}/components/libraries/util/app_error_handler_gcc.c"
            "${NRF5_SDK_PATH}/components/libraries/util/app_util_platform.c"
            "${NRF5_SDK_PATH}/components/libraries/util/sdk_mapped_flags.c"
    )

    # adds target for erasing and flashing the board with a softdevice
    add_custom_target(FLASH_SOFTDEVICE ALL
            COMMAND ${NRFJPROG} --program ${NRF_SOFTDEVICE_PATH} -f ${NRF_TARGET} --sectorerase
            COMMAND sleep 0.5s
            COMMAND ${NRFJPROG} --reset -f ${NRF_TARGET}
            COMMENT "flashing SoftDevice"
            )

    add_custom_target(FLASH_ERASE ALL
            COMMAND ${NRFJPROG} --eraseall -f ${NRF_TARGET}
            COMMENT "erasing flashing"
            )

    if(${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Darwin")
        set(TERMINAL "open")
    elseif(${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Windows")
        set(TERMINAL "sh")
    else()
        set(TERMINAL "gnome-terminal")
    endif()

    add_custom_target(START_JLINK ALL
            COMMAND ${TERMINAL} "${DIR_OF_nRF5_CMAKE}/runJLinkGDBServer-${NRF_TARGET}"
            COMMAND ${TERMINAL} "${DIR_OF_nRF5_CMAKE}/runJLinkExe-${NRF_TARGET}"
            COMMAND sleep 2s
            COMMAND ${TERMINAL} "${DIR_OF_nRF5_CMAKE}/runJLinkRTTClient"
            COMMENT "started JLink commands"
            )

endmacro(nRF5_setup)

# adds a target for comiling and flashing an executable
macro(nRF5_executable EXECUTABLE_NAME SOURCE_FILES)
    # executable
    add_executable(${EXECUTABLE_NAME} ${SDK_SOURCE_FILES} ${SOURCE_FILES})
    set_target_properties(${EXECUTABLE_NAME} PROPERTIES SUFFIX ".out")
    set_target_properties(${EXECUTABLE_NAME} PROPERTIES LINK_FLAGS "-Wl,-Map=${EXECUTABLE_NAME}.map")

    # additional POST BUILD setps to create the .bin and .hex files
    add_custom_command(TARGET ${EXECUTABLE_NAME}
            POST_BUILD
            COMMAND ${CMAKE_SIZE_UTIL} ${EXECUTABLE_NAME}.out
            COMMAND ${CMAKE_OBJCOPY} -O binary ${EXECUTABLE_NAME}.out "${EXECUTABLE_NAME}.bin"
            COMMAND ${CMAKE_OBJCOPY} -O ihex ${EXECUTABLE_NAME}.out "${EXECUTABLE_NAME}.hex"
            COMMENT "post build steps for ${EXECUTABLE_NAME}")

    # custom target for flashing the board
    add_custom_target("FLASH_${EXECUTABLE_NAME}" ALL
            DEPENDS ${EXECUTABLE_NAME}
            COMMAND ${NRFJPROG} --program ${EXECUTABLE_NAME}.hex -f ${NRF_TARGET} --sectorerase
            COMMAND sleep 0.5s
            COMMAND ${NRFJPROG} --reset -f ${NRF_TARGET}
            COMMENT "flashing ${EXECUTABLE_NAME}.hex"
            )

endmacro()

# Legacy symbols for linker
macro(nRF5_SdkLegacy)
    list(APPEND SDK_SOURCE_FILES
            "${NRF5_SDK_PATH}/integration/nrfx/legacy/nrf_drv_clock.c"
            "${NRF5_SDK_PATH}/integration/nrfx/legacy/nrf_drv_power.c"
            "${NRF5_SDK_PATH}/integration/nrfx/legacy/nrf_drv_uart.c"
            )
endmacro(nRF5_SdkLegacy)

macro(nRF5_SdkExternal)
    # Other external
    include_directories(
            "${NRF5_SDK_PATH}/external/fprintf/"
            "${NRF5_SDK_PATH}/external/utf_converter/"
            "${NRF5_SDK_PATH}/external/fnmatch/"
    )

    list(APPEND SDK_SOURCE_FILES
            "${NRF5_SDK_PATH}/external/utf_converter/utf.c"
            "${NRF5_SDK_PATH}/external/fprintf/nrf_fprintf.c"
            "${NRF5_SDK_PATH}/external/fprintf/nrf_fprintf_format.c"
            "${NRF5_SDK_PATH}/external/fnmatch/fnmatch.c"
            )
endmacro(nRF5_SdkExternal)

macro(nRF5_CLI)
    include_directories(
            "${NRF5_SDK_PATH}/components/libraries/cli"
            "${NRF5_SDK_PATH}/components/libraries/cli/cdc_acm"
            "${NRF5_SDK_PATH}/components/libraries/cli/uart"
            "${NRF5_SDK_PATH}/components/libraries/cli/rtt"
    )

    list(APPEND SDK_SOURCE_FILES
            "${NRF5_SDK_PATH}/components/libraries/mpu/nrf_mpu_lib.c"
            "${NRF5_SDK_PATH}/components/libraries/cli/cli_utils_cmds.c"
            "${NRF5_SDK_PATH}/components/libraries/cli/cdc_acm/nrf_cli_cdc_acm.c"
            "${NRF5_SDK_PATH}/components/libraries/cli/rtt/nrf_cli_rtt.c"
            "${NRF5_SDK_PATH}/components/libraries/cli/uart/nrf_cli_uart.c"
            "${NRF5_SDK_PATH}/components/libraries/cli/nrf_cli.c"
            )
endmacro(nRF5_CLI)

macro(nRF5_USB)
    include_directories(
            "${NRF5_SDK_PATH}/components/libraries/usbd"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/audio"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/cdc"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/cdc/acm"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/hid"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/hid/generic"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/hid/kbd"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/hid/mouse"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/msc"
    )

    list(APPEND SDK_SOURCE_FILES
            "${NRF5_SDK_PATH}/modules/nrfx/drivers/src/nrfx_usbd.c"
            "${NRF5_SDK_PATH}/components/libraries/usbd/app_usbd.c"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/cdc/acm/app_usbd_cdc_acm.c"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/dummy/app_usbd_dummy.c"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/nrf_dfu_trigger/app_usbd_nrf_dfu_trigger.c"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/audio/app_usbd_audio.c"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/msc/app_usbd_msc.c"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/hid/kbd/app_usbd_hid_kbd.c"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/hid/mouse/app_usbd_hid_mouse.c"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/hid/generic/app_usbd_hid_generic.c"
            "${NRF5_SDK_PATH}/components/libraries/usbd/class/hid/app_usbd_hid.c"
            "${NRF5_SDK_PATH}/components/libraries/usbd/app_usbd_core.c"
            "${NRF5_SDK_PATH}/components/libraries/usbd/app_usbd_string_desc.c"
            "${NRF5_SDK_PATH}/components/libraries/usbd/app_usbd_serial_num.c"
    )
endmacro(nRF5_USB)

macro(nRF5_SdkSeggerRTT)
    # Segger RTT
    include_directories(
            "${NRF5_SDK_PATH}/external/segger_rtt/"
    )

    list(APPEND SDK_SOURCE_FILES
            "${NRF5_SDK_PATH}/external/segger_rtt/SEGGER_RTT_Syscalls_GCC.c"
            "${NRF5_SDK_PATH}/external/segger_rtt/SEGGER_RTT.c"
            "${NRF5_SDK_PATH}/external/segger_rtt/SEGGER_RTT_printf.c"
            )
endmacro(nRF5_SdkSeggerRTT)

macro(nRF5_SdkExternalBLE)
    # Common Bluetooth Low Energy files
    include_directories(
            "${NRF5_SDK_PATH}/components/ble"
            "${NRF5_SDK_PATH}/components/ble/common"
            "${NRF5_SDK_PATH}/components/ble/ble_advertising"
            "${NRF5_SDK_PATH}/components/ble/ble_dtm"
            "${NRF5_SDK_PATH}/components/ble/ble_link_ctx_manager"
            "${NRF5_SDK_PATH}/components/ble/ble_racp"
            "${NRF5_SDK_PATH}/components/ble/nrf_ble_qwr"
            "${NRF5_SDK_PATH}/components/ble/peer_manager"
    )

    list(APPEND SDK_SOURCE_FILES
            "${NRF5_SDK_PATH}/components/softdevice/common/nrf_sdh_ble.c"
            "${NRF5_SDK_PATH}/components/ble/common/ble_advdata.c"
            "${NRF5_SDK_PATH}/components/ble/common/ble_conn_params.c"
            "${NRF5_SDK_PATH}/components/ble/common/ble_conn_state.c"
            "${NRF5_SDK_PATH}/components/ble/common/ble_srv_common.c"
            "${NRF5_SDK_PATH}/components/ble/ble_advertising/ble_advertising.c"
            "${NRF5_SDK_PATH}/components/ble/ble_link_ctx_manager/ble_link_ctx_manager.c"
            "${NRF5_SDK_PATH}/components/ble/ble_services/ble_nus/ble_nus.c"
            "${NRF5_SDK_PATH}/components/ble/nrf_ble_qwr/nrf_ble_qwr.c"
            )
endmacro(nRF5_SdkExternalBLE)
# End Paul

# adds app-level scheduler library
macro(nRF5_AppScheduler)
    include_directories(
            "${NRF5_SDK_PATH}/components/libraries/scheduler"
    )

    list(APPEND SDK_SOURCE_FILES
            "${NRF5_SDK_PATH}/components/libraries/scheduler/app_scheduler.c"
            )

endmacro(nRF5_AppScheduler)

# adds app-level FIFO libraries
macro(nRF5_AppFIFO)
    include_directories(
            "${NRF5_SDK_PATH}/components/libraries/fifo"
    )

    list(APPEND SDK_SOURCE_FILES
            "${NRF5_SDK_PATH}/components/libraries/fifo/app_fifo.c"
            )

endmacro(nRF5_AppFIFO)

# adds app-level Timer libraries
macro(nRF5_AppTimer)
    list(APPEND SDK_SOURCE_FILES
            "${NRF5_SDK_PATH}/components/libraries/timer/app_timer.c"
            )
endmacro(nRF5_AppTimer)

# adds app-level UART libraries
macro(nRF5_AppUART)
    list(APPEND SDK_SOURCE_FILES
            "${NRF5_SDK_PATH}/components/libraries/uart/app_uart_fifo.c"
    )
endmacro(nRF5_AppUART)

macro(nRF5_AppUARTE)
    list(APPEND SDK_SOURCE_FILES
            "${NRF5_SDK_PATH}/components/libraries/libuarte/nrf_libuarte_drv.c"
            "${NRF5_SDK_PATH}/components/libraries/libuarte/nrf_libuarte_async.c"
            "${NRF5_SDK_PATH}/components/libraries/cli/libuarte/nrf_cli_libuarte.c"
    )
endmacro(nRF5_AppUARTE)


# adds app-level Button library
macro(nRF5_AppButton)
    include_directories(
            "${NRF5_SDK_PATH}/components/libraries/button"
    )

    list(APPEND SDK_SOURCE_FILES
            "${NRF5_SDK_PATH}/components/libraries/button/app_button.c"
            )

endmacro(nRF5_AppButton)

# adds BSP (board support package) library
macro(nRF5_BSP WITH_BLE_BTN WITH_ANT_BTN WITH_NFC)
    include_directories(
            "${NRF5_SDK_PATH}/components/libraries/bsp"
    )

    list(APPEND SDK_SOURCE_FILES
            "${NRF5_SDK_PATH}/components/libraries/bsp/bsp.c"
            )

    if (${WITH_BLE_BTN})
        list(APPEND SDK_SOURCE_FILES
                "${NRF5_SDK_PATH}/components/libraries/bsp/bsp_btn_ble.c"
                )
    endif ()

    if (${WITH_ANT_BTN})
        list(APPEND SDK_SOURCE_FILES
                "${NRF5_SDK_PATH}/components/libraries/bsp/bsp_btn_ant.c"
                )
    endif ()

    if (${WITH_NFC})
        list(APPEND SDK_SOURCE_FILES
                "${NRF5_SDK_PATH}/components/libraries/bsp/bsp_nfc.c"
                )
    endif ()

endmacro(nRF5_BSP)

# adds Bluetooth Low Energy GATT support library
macro(nRF5_BLEGATT)
    include_directories(
            "${NRF5_SDK_PATH}/components/ble/nrf_ble_gatt"
    )

    list(APPEND SDK_SOURCE_FILES
            "${NRF5_SDK_PATH}/components/ble/nrf_ble_gatt/nrf_ble_gatt.c"
            )

endmacro(nRF5_BLEGATT)

# adds Bluetooth Low Energy advertising support library
macro(nRF5_BLEAdvertising)
    include_directories(
            "${NRF5_SDK_PATH}/components/ble/ble_advertising"
    )

    list(APPEND SDK_SOURCE_FILES
            "${NRF5_SDK_PATH}/components/ble/ble_advertising/ble_advertising.c"
            )

endmacro(nRF5_BLEAdvertising)

# adds Bluetooth Low Energy advertising support library
macro(nRF5_BLEPeerManager)
    include_directories(
            "${NRF5_SDK_PATH}/components/ble/peer_manager"
    )

    list(APPEND SDK_SOURCE_FILES
            "${NRF5_SDK_PATH}/components/ble/peer_manager/auth_status_tracker.c"
            "${NRF5_SDK_PATH}/components/ble/peer_manager/gatt_cache_manager.c"
            "${NRF5_SDK_PATH}/components/ble/peer_manager/gatts_cache_manager.c"
            "${NRF5_SDK_PATH}/components/ble/peer_manager/id_manager.c"
            "${NRF5_SDK_PATH}/components/ble/peer_manager/nrf_ble_lesc.c"
            "${NRF5_SDK_PATH}/components/ble/peer_manager/peer_data_storage.c"
            "${NRF5_SDK_PATH}/components/ble/peer_manager/peer_database.c"
            "${NRF5_SDK_PATH}/components/ble/peer_manager/peer_id.c"
            "${NRF5_SDK_PATH}/components/ble/peer_manager/peer_manager.c"
            "${NRF5_SDK_PATH}/components/ble/peer_manager/peer_manager_handler.c"
            "${NRF5_SDK_PATH}/components/ble/peer_manager/pm_buffer.c"
            "${NRF5_SDK_PATH}/components/ble/peer_manager/security_dispatcher.c"
            "${NRF5_SDK_PATH}/components/ble/peer_manager/security_manager.c"
    )

endmacro(nRF5_BLEPeerManager)

# adds app-level FDS (flash data storage) library
# SD Solid Drive Controller
# NVMC Non-Volatile Memory Controller
macro(nRF5_AppFDS SD NVMC)
    include_directories(
        "${NRF5_SDK_PATH}/components/libraries/fds"
        "${NRF5_SDK_PATH}/components/libraries/experimental_section_vars"
    )
    list(APPEND SDK_SOURCE_FILES
        "${NRF5_SDK_PATH}/modules/nrfx/hal/nrf_nvmc.c"
        "${NRF5_SDK_PATH}/components/libraries/fds/fds.c"
        "${NRF5_SDK_PATH}/components/libraries/fstorage/nrf_fstorage.c"
    )
    if(${SD})
        list(APPEND SDK_SOURCE_FILES
            "${NRF5_SDK_PATH}/components/libraries/fstorage/nrf_fstorage_sd.c"
        )
    endif()
    if(${NVMC})
        list(APPEND SDK_SOURCE_FILES
            "${NRF5_SDK_PATH}/components/libraries/fstorage/nrf_fstorage_nvmc.c"
        )
    endif()

endmacro(nRF5_AppFDS)

# adds NFC library
macro(nRF5_NFC)
    # NFC includes
    include_directories(
        "${NRF5_SDK_PATH}/components/nfc/ndef/conn_hand_parser"
        "${NRF5_SDK_PATH}/components/nfc/ndef/conn_hand_parser/ac_rec_parser"
        "${NRF5_SDK_PATH}/components/nfc/ndef/conn_hand_parser/ble_oob_advdata_parser"
        "${NRF5_SDK_PATH}/components/nfc/ndef/conn_hand_parser/le_oob_rec_parser"
        "${NRF5_SDK_PATH}/components/nfc/ndef/connection_handover/ac_rec"
        "${NRF5_SDK_PATH}/components/nfc/ndef/connection_handover/ble_oob_advdata"
        "${NRF5_SDK_PATH}/components/nfc/ndef/connection_handover/ble_pair_lib"
        "${NRF5_SDK_PATH}/components/nfc/ndef/connection_handover/ble_pair_msg"
        "${NRF5_SDK_PATH}/components/nfc/ndef/connection_handover/common"
        "${NRF5_SDK_PATH}/components/nfc/ndef/connection_handover/ep_oob_rec"
        "${NRF5_SDK_PATH}/components/nfc/ndef/connection_handover/hs_rec"
        "${NRF5_SDK_PATH}/components/nfc/ndef/connection_handover/le_oob_rec"
        "${NRF5_SDK_PATH}/components/nfc/ndef/generic/message"
        "${NRF5_SDK_PATH}/components/nfc/ndef/generic/record"
        "${NRF5_SDK_PATH}/components/nfc/ndef/launchapp"
        "${NRF5_SDK_PATH}/components/nfc/ndef/parser/message"
        "${NRF5_SDK_PATH}/components/nfc/ndef/parser/record"
        "${NRF5_SDK_PATH}/components/nfc/ndef/text"
        "${NRF5_SDK_PATH}/components/nfc/ndef/uri"
        "${NRF5_SDK_PATH}/components/nfc/t2t_lib"
        "${NRF5_SDK_PATH}/components/nfc/t2t_parser"
        "${NRF5_SDK_PATH}/components/nfc/t4t_lib"
        "${NRF5_SDK_PATH}/components/nfc/t4t_parser/apdu"
        "${NRF5_SDK_PATH}/components/nfc/t4t_parser/cc_file"
        "${NRF5_SDK_PATH}/components/nfc/t4t_parser/hl_detection_procedure"
        "${NRF5_SDK_PATH}/components/nfc/t4t_parser/tlv"
    )

    list(APPEND SDK_SOURCE_FILES
        "${NRF5_SDK_PATH}/components/nfc"
    )

endmacro(nRF5_NFC)

macro(nRF5_BLEService NAME)
    include_directories(
            "${NRF5_SDK_PATH}/components/ble/ble_services/${NAME}"
    )

    list(APPEND SDK_SOURCE_FILES
            "${NRF5_SDK_PATH}/components/ble/ble_services/${NAME}/${NAME}.c"
            )

endmacro(nRF5_BLEService)
