#ifndef SDK_CONFIG_H
#define SDK_CONFIG_H

#ifndef NRF_LOG_ENABLED
#define NRF_LOG_ENABLED 0
#endif

// <e> NRF_STACK_GUARD_ENABLED - nrf_stack_guard - Stack guard
//==========================================================
#ifndef NRF_STACK_GUARD_ENABLED
#define NRF_STACK_GUARD_ENABLED 1
#endif
// <o> NRF_STACK_GUARD_CONFIG_SIZE  - Size of the stack guard.

// <5=> 32 bytes
// <6=> 64 bytes
// <7=> 128 bytes
// <8=> 256 bytes
// <9=> 512 bytes
// <10=> 1024 bytes
// <11=> 2048 bytes
// <12=> 4096 bytes

#ifndef NRF_STACK_GUARD_CONFIG_SIZE
#define NRF_STACK_GUARD_CONFIG_SIZE 7
#endif

#endif // SDK_CONFIG_H