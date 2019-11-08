cmake_minimum_required(VERSION 3.12)

project(BlinkyExample C ASM)

# NRF SDK setup, required
nRF5x_setup()

# SDK Modules to import
nRF5x_addAppScheduler()
nRF5x_addAppFIFO()
nRF5x_addAppTimer()
nRF5x_addAppUART()
nRF5x_addAppButton()

add_definitions(-DCONFIG_GPIO_AS_PINRESET)

# usually you would include files in this directory here, like so:
#include_directories(.)
#list(APPEND SOURCE_FILES main.c)

# for example projects we include the example source files
include_directories(${NRF_CONFIG})
list(APPEND SOURCE_FILES ${PROJECT_PATH}/main.c)

nRF5x_addExecutable(BlinkyExample "${SOURCE_FILES}")
