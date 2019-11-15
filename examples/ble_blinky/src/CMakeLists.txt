cmake_minimum_required(VERSION 3.12)

project(BlinkyExample C ASM)

# NRF SDK setup, required
nRF5_setup()

# SDK Modules to import
nRF5_SdkExternal()
nRF5_SdkExternalBLE()
nRF5_AppScheduler()
nRF5_AppFIFO()
nRF5_AppTimer()
nRF5_AppUART()
nRF5_AppButton()
nRF5_BLEGATT()
nRF5_BSP(TRUE FALSE FALSE)

nRF5_BLEService(ble_lbs)

# Legacy symbols for linker
nRF5_SdkLegacy()

# Every project has unique compiler flags set by Nordic. Get them from each example project Makefile
add_definitions(-DCONFIG_GPIO_AS_PINRESET)
add_definitions(-DNRF52_PAN_74 -DNRF52_PAN_64 -DNRF52_PAN_12 -DNRF52_PAN_58 -DNRF52_PAN_54 -DNRF52_PAN_31)
add_definitions(-DNRF52_PAN_51 -DNRF52_PAN_36 -DNRF52_PAN_15 -DNRF52_PAN_20 -DNRF52_PAN_55)

# usually you would include files in this directory here, like so:
#include_directories(.)
#list(APPEND SOURCE_FILES main.c)

# for example projects we include the example source files
include_directories(${NRF_CONFIG})
list(APPEND SOURCE_FILES ${PROJECT_PATH}/main.c)

nRF5_Executable(BlinkyExample "${SOURCE_FILES}")