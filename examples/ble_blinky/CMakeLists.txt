cmake_minimum_required(VERSION 3.12)

include("nrf-toolchain.cmake")

set(NRF_TARGET nrf52)

# Available Boards
# nrf51 pca10028 (nrf51422)
# nrf52 pca10040 (nrf52832), pca10056 (nrf52840), pca10040e (nrf52810), pca10056e (nrf52811), pca10059 (nrf52840)
set(NRF_BOARD pca10056)

# Available Softdevices
# mbr/ s112/   s132/   s140/   s212/  -Not tested:  s312/   s332/   s340/
# SoftDevice s112 is a small Bluetooth 5 protocol stack for the nRF52810, nRF52811 and nRF52832 SoCs.
# SoftDevice s113 is a small Bluetooth 5 protocol stack for the nRF52810, nRF52811, nRF52832 and nRF52840 SoCs.
# SoftDevice s132 is a high performance Bluetooth 5 protocol stack for the nRF52810 and nRF52832 SoCs.
# SoftDevice s140 is a feature-complete Bluetooth 5 qualified protocol stack for the nRF52811 and nRF52840 SoCs.
# SoftDevice S212 is a highly flexible ANT™ protocol stack for the the nRF52810 and nRF52832 SoCs.
# SoftDevice S312 is a combined Bluetooth 5 and ANT™ protocol stack for the nRF52810 SoC, supporting concurrent operation of the two.
# SoftDevice S332 is a combined Bluetooth 5 and ANT protocol stack for the nRF52832, supporting concurrent operation of the two.
# SoftDevice S340 is a combined Bluetooth 5 and ANT™ protocol stack for the nRF52840 SoC, supporting concurrent operation of the two.
set(NRF_SOFTDEVICE s140)
# Only for mbr softdevice: nrf52810/ nrf52832/ nrf52840/
set(NRF_MODEL nrf52840)

# Set program (ram) memory allocation
# Standard Stack is 2048 for e-series pca10040e (nrf52810), pca10056e (nrf52811)
# and 8192 for pca10040 (nrf52832), pca10056 (nrf52840), pca10059 (nrf52840)
# Heap size set to 0 will force the linker to assing it to the remaining free memory
# Check https://engineering.stackexchange.com/questions/4013/defining-the-heap-and-stack-size-for-an-arm-cortex-m4-microcontroller for more
# nrf52840 has 256kB or 262144 bytes but static variables and softdevice uses ram too
set(STACK_SIZE 16384)
set(HEAP_SIZE 0)

# Magic numbers from SDK, can be redefined
# set(NRF_CRYPTO_BACKEND_CC310_BL_HASH_AUTOMATIC_RAM_BUFFER_SIZE 4096)
# set(NRF_STACK_GUARD_CONFIG_SIZE 7)

# SDK example to be added to the sources
set(PROJECT_PATH ${NRF5_SDK_PATH}/examples/ble_peripheral/ble_app_blinky)
set(NRF_CONFIG ${PROJECT_PATH}/${NRF_BOARD}/${NRF_SOFTDEVICE}/config)

# Softdevice hex for flashing. Set only if the project needs to access it.
set(NRF_SOFTDEVICE_PATH "${NRF5_SDK_PATH}/components/softdevice/${NRF_SOFTDEVICE}/hex/${NRF_SOFTDEVICE}_nrf52_6.1.1_softdevice.hex")
#set(NRF_SOFTDEVICE_PATH "${NRF5_SDK_PATH}/components/softdevice/${NRF_SOFTDEVICE}/${NRF_BOARD}/hex/mbr_nrf52_2.4.1_mbr.hex")

# you can specify the location of the linker script if desired instead of using a specific file name
set(NRF5_LINKER_SCRIPT ${PROJECT_PATH}/${NRF_BOARD}/${NRF_SOFTDEVICE}/armgcc/ble_app_blinky_gcc_nrf52.ld)

# Import cmake automation
include("./CMake_nRF5x.cmake")

nRF5x_toolchainSetup()

project(ExampleProject C ASM)

add_subdirectory(src)
