cmake_minimum_required(VERSION 3.12)

include("../../nrf-toolchain.cmake")

set(NRF_TARGET nrf52)

# Available Boards
# nrf51 pca10028
# nrf52 pca10040, pca10056, pca10040e, pca10056e, pca10059
set(NRF_BOARD pca10056)

# Available Softdevices
# s112/   s132/   s140/   s212/   s312/   s332/   s340/
# SoftDevice s112 is a small Bluetooth 5 protocol stack for the nRF52810, nRF52811 and nRF52832 SoCs.
# SoftDevice s113 is a small Bluetooth 5 protocol stack for the nRF52810, nRF52811, nRF52832 and nRF52840 SoCs.
# SoftDevice s132 is a high performance Bluetooth 5 protocol stack for the nRF52810 and nRF52832 SoCs.
# SoftDevice s140 is a feature-complete Bluetooth 5 qualified protocol stack for the nRF52811 and nRF52840 SoCs.
# SoftDevice S212 is a highly flexible ANT™ protocol stack for the the nRF52810 and nRF52832 SoCs.
# SoftDevice S312 is a combined Bluetooth 5 and ANT™ protocol stack for the nRF52810 SoC, supporting concurrent operation of the two.
# SoftDevice S332 is a combined Bluetooth 5 and ANT protocol stack for the nRF52832, supporting concurrent operation of the two.
# SoftDevice S340 is a combined Bluetooth 5 and ANT™ protocol stack for the nRF52840 SoC, supporting concurrent operation of the two.
set(NRF_SOFTDEVICE s113)

# SDK example to be added to the sources
set(PROJECT_PATH ${NRF5_SDK_PATH}/examples/peripheral/blinky)
set(NRF_CONFIG ${PROJECT_PATH}/${NRF_BOARD}/blank/config)

# you can specify the location of the linker script if desired instead of using a specific file name
set(NRF5_LINKER_SCRIPT ${PROJECT_PATH}/${NRF_BOARD}/blank/armgcc/blinky_gcc_nrf52.ld)
message(WARNING ${NRF5_LINKER_SCRIPT})

# Import cmake automation
include("../../CMake_nRF5x.cmake")

nRF5x_toolchainSetup()

project(ExampleProject C ASM)

add_subdirectory(src)
