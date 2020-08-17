# MIT License

# Copyright (c) 2020 Polidea

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

include("nrf5_utils")

function(nrf5_get_sdk_version sdk_path out_sdk_version)
  if(NOT EXISTS ${sdk_path})
    message(FATAL_ERROR "Specified nRF SDK doesn't exist: ${sdk_path}")
  endif()
  set(release_notes_path "${sdk_path}/documentation/release_notes.txt")
  if(NOT EXISTS "${release_notes_path}")
    message(FATAL_ERROR "Cannot find release notes in following SDK: ${release_notes_path}")
  endif()
  file(STRINGS "${release_notes_path}" release_notes LIMIT_COUNT 1)
  string(REGEX MATCH "[0-9]+\.[0-9]+\.[0-9]+" version "${release_notes}")
  set(${out_sdk_version} ${version} PARENT_SCOPE)
endfunction()

function(nrf5_validate_sdk_version sdk_version)
  set(supported_sdk_versions "15.3.0" "16.0.0")
  list(FIND supported_sdk_versions ${sdk_version} sdk_version_index)
  if(sdk_version_index EQUAL -1)
    message(FATAL_ERROR "Provided nRF SDK version ${sdk_version} is not supported, try these: ${supported_sdk_versions}")
  endif()
endfunction()

function(nrf5_get_board_target sdk_version board out_target out_define)
  # Information about the board. In order:
  # * Board target
  # * Board define
  # * Min SDK version
  # * Max SDK version

  set(target_key 0)
  set(define_key 1)
  set(min_sdk_key 2)
  set(max_sdk_key 3)

  set(board_nrf6310       nrf51822_xxaa BOARD_NRF6310  15.3.0 16.0.0)
  set(board_pca10000      nrf51822_xxaa BOARD_PCA10000 15.3.0 16.0.0)
  set(board_pca10001      nrf51822_xxaa BOARD_PCA10001 15.3.0 16.0.0)
  set(board_pca10002      nrf51422_xxaa BOARD_PCA10002 15.3.0 16.0.0)
  set(board_pca10003      nrf51422_xxaa BOARD_PCA10003 15.3.0 16.0.0)
  set(board_pca20006      nrf51422_xxac BOARD_PCA20006 15.3.0 16.0.0)
  set(board_pca10028      nrf51422_xxac BOARD_PCA10028 15.3.0 16.0.0)
  set(board_pca10031      nrf51422_xxac BOARD_PCA10031 15.3.0 16.0.0)
  set(board_pca10036      nrf52832_xxaa BOARD_PCA10036 15.3.0 16.0.0)
  set(board_pca10040      nrf52832_xxaa BOARD_PCA10040 15.3.0 16.0.0)
  set(board_pca10040e     nrf52810_xxaa BOARD_PCA10040 15.3.0 16.0.0)
  set(board_pca10056      nrf52840_xxaa BOARD_PCA10056 15.3.0 16.0.0)
  set(board_pca10056e     nrf52811_xxaa BOARD_PCA10056 15.3.0 16.0.0)
  set(board_pca10100      nrf52833_xxaa BOARD_PCA10100 15.3.0 15.3.0)
  set(board_pca20020      nrf52832_xxaa BOARD_PCA20020 15.3.0 16.0.0)
  set(board_pca10059      nrf52840_xxaa BOARD_PCA10059 15.3.0 16.0.0)
  set(board_wt51822       nrf51822_xxaa BOARD_WT51822  15.3.0 16.0.0)
  set(board_n5dk1         nrf51422_xxaa BOARD_N5DK1    15.3.0 16.0.0)
  set(board_d52dk1        nrf52832_xxaa BOARD_D52DK1   15.3.0 16.0.0)
  set(board_arduinoprimo  nrf52832_xxaa BOARD_ARDUINO_PRIMO 15.3.0 16.0.0)
  # TODO: Support for custom boards?

  if(NOT board_${board})
    message(FATAL_ERROR "Unsupported nRF board: ${board}")
  endif()

  list(GET board_${board} ${min_sdk_key} board_min_ver)
  list(GET board_${board} ${max_sdk_key} board_max_ver)
  if((sdk_version VERSION_LESS board_min_ver) OR (sdk_version VERSION_GREATER board_max_ver))
    message(FATAL_ERROR "Unsupported nRF board ${board} in version ${sdk_version}")
  endif()

  list(GET board_${board} ${target_key} board_target)
  set(${out_target} ${board_target} PARENT_SCOPE)

  list(GET board_${board} ${define_key} board_define)
  set(${out_define} ${board_define} PARENT_SCOPE)
endfunction()

function(nrf5_get_target_flags sdk_version target out_target out_target_short out_target_flags)
  # Handle aliases
  set(target_alias_nrf51801 nrf51801_xxab)
  set(target_alias_nrf51802 nrf51802_xxaa)
  set(target_alias_nrf51822 nrf51822_xxaa)
  set(target_alias_nrf51824 nrf51824_xxaa)
  set(target_alias_nrf51422 nrf51422_xxaa)
  set(target_alias_nrf52805 nrf52805_xxaa)
  set(target_alias_nrf52810 nrf52810_xxaa)
  set(target_alias_nrf52811 nrf52811_xxaa)
  set(target_alias_nrf52832 nrf52832_xxaa)
  set(target_alias_nrf52833 nrf52833_xxaa)
  set(target_alias_nrf52840 nrf52840_xxaa)

  if(target_alias_${target})
    message(WARNING "${target} target specified, assuming ${target_alias_${target}}.")
    set(target ${target_alias_${target}})
  endif()
  
  # List of supported targets
  set(target_key 0)
  set(define_key 1)
  set(min_sdk_key 2)
  set(max_sdk_key 3)

  set(target_nrf51801_xxab nrf51801 NRF51801_XXAB 15.3.0 16.0.0)
  set(target_nrf51802_xxaa nrf51802 NRF51802_XXAA 15.3.0 16.0.0)
  set(target_nrf51822_xxaa nrf51822 NRF51822_XXAA 15.3.0 16.0.0)
  set(target_nrf51822_xxab nrf51822 NRF51822_XXAB 15.3.0 16.0.0)
  set(target_nrf51822_xxac nrf51822 NRF51822_XXAC 15.3.0 16.0.0)
  set(target_nrf51824_xxaa nrf51824 NRF51824_XXAA 15.3.0 16.0.0)
  set(target_nrf51422_xxaa nrf51422 NRF51422_XXAA 15.3.0 16.0.0)
  set(target_nrf51422_xxab nrf51422 NRF51422_XXAB 15.3.0 16.0.0)
  set(target_nrf51422_xxac nrf51422 NRF51422_XXAC 15.3.0 16.0.0)
  set(target_nrf52805_xxaa nrf52805 NRF52805_XXAA 15.3.0 16.0.0)
  set(target_nrf52810_xxaa nrf52810 NRF52810_XXAA 15.3.0 16.0.0)
  set(target_nrf52811_xxaa nrf52811 NRF52811_XXAA 15.3.0 16.0.0)
  set(target_nrf52832_xxaa nrf52832 NRF52832_XXAA 15.3.0 16.0.0)
  set(target_nrf52832_xxab nrf52832 NRF52832_XXAB 15.3.0 16.0.0)
  set(target_nrf52833_xxaa nrf52833 NRF52833_XXAA 16.0.0 16.0.0)
  set(target_nrf52840_xxaa nrf52840 NRF52840_XXAA 15.3.0 16.0.0)

  if(NOT target_${target})
    message(FATAL_ERROR "Unsupported nRF target: ${target}")
  endif()

  list(GET target_${target} ${target_key} target_value)
  list(GET target_${target} ${define_key} define_value)
  list(GET target_${target} ${min_sdk_key} min_sdk_value)
  list(GET target_${target} ${max_sdk_key} max_sdk_value)

  if((sdk_version VERSION_LESS min_sdk_value) OR (sdk_version VERSION_GREATER max_sdk_value))
    message(FATAL_ERROR "Unsupported nRF target ${target} in version ${sdk_version}")
  endif()

  # Common compiler flags for C, ASM and Linker.

  set(nrf51801_flags -DNRF51 -DNRF51801 -mcpu=cortex-m0 -mfloat-abi=soft -DFLOAT_ABI_SOFT)
  set(nrf51802_flags -DNRF51 -DNRF51802 -mcpu=cortex-m0 -mfloat-abi=soft -DFLOAT_ABI_SOFT)
  set(nrf51822_flags -DNRF51 -DNRF51822 -mcpu=cortex-m0 -mfloat-abi=soft -DFLOAT_ABI_SOFT)
  set(nrf51824_flags -DNRF51 -DNRF51824 -mcpu=cortex-m0 -mfloat-abi=soft -DFLOAT_ABI_SOFT)
  set(nrf51422_flags -DNRF51 -DNRF51422 -mcpu=cortex-m0 -mfloat-abi=soft -DFLOAT_ABI_SOFT)
  set(nrf52805_flags -mcpu=cortex-m4 -mfloat-abi=soft -DFLOAT_ABI_SOFT)
  set(nrf52810_flags -mcpu=cortex-m4 -mfloat-abi=soft -DFLOAT_ABI_SOFT)
  set(nrf52811_flags -mcpu=cortex-m4 -mfloat-abi=soft -DFLOAT_ABI_SOFT)
  set(nrf52832_flags -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16 -DFLOAT_ABI_HARD)
  set(nrf52833_flags -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16 -DFLOAT_ABI_HARD)
  set(nrf52840_flags -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16 -DFLOAT_ABI_HARD)

  set(${out_target} ${target} PARENT_SCOPE)
  set(${out_target_short} ${target_value} PARENT_SCOPE)
  set(${out_target_flags} ${${target_value}_flags} "-D${define_value}" PARENT_SCOPE)

endfunction()

function(nrf5_find_linker_file sdk_path sdk_version target sd_variant out_linker_file_path)
  nrf5_split_target(${target} target_family target_variant target_group)
  set(linker_path_patterns 
    # Config files (contain necessary sections)
    "${sdk_path}/config/${target_group}/armgcc/*.ld"
    # SoftDevice linker files (contain good start/end sections)
    "${sdk_path}/components/softdevice/${sd_variant}/toolchain/armgcc/*${sd_variant}*${target}*.ld"
    # MDK linker files (for explicit target)
    "${sdk_path}/modules/nrfx/mdk/*${target}*.ld"
    # More generic MDK files for specific board variant
    "${sdk_path}/modules/nrfx/mdk/*${target_family}_${target_variant}*.ld"
  )
  nrf5_find_file_path_with_patterns("${linker_path_patterns}" linker_file_path)
  set(${out_linker_file_path} "${linker_file_path}" PARENT_SCOPE)
endfunction()

function(nrf5_find_sdk_config_file sdk_path sdk_version target out_sdk_config_path)
  nrf5_split_target(${target} target_family target_variant target_group)
  set(sdk_config_path_patterns 
    # Common config file for taget group
    "${sdk_path}/config/${target_group}/config"
  )
  nrf5_find_file_path_with_patterns("${sdk_config_path_patterns}" sdk_config_path)
  set(${out_sdk_config_path} "${sdk_config_path}" PARENT_SCOPE)
endfunction()

function(nrf5_get_startup_file sdk_path target out_startup_file out_system_file)
  nrf5_split_target(${target} target_family target_variant target_group)
  set(startup_file_patterns 
    # Target specific startup file.
    "${sdk_path}/modules/nrfx/mdk/gcc_startup_${target_group}.S"
    # Family specific startup file.
    "${sdk_path}/modules/nrfx/mdk/gcc_startup_${target_family}.S"
  )

  nrf5_find_file_path_with_patterns("${startup_file_patterns}" startup_file)
  if (NOT startup_file)
    message(FATAL_ERROR "Cannot find startup file for ${target}")
  endif()

  set(system_file_patterns 
    # Target specific system file.
    "${sdk_path}/modules/nrfx/mdk/system_${target_group}.c"
    # Family specific system file.
    "${sdk_path}/modules/nrfx/mdk/system_${target_family}.c"
  )

  nrf5_find_file_path_with_patterns("${system_file_patterns}" system_file)
  if (NOT system_file)
    message(FATAL_ERROR "Cannot find system file for ${target}")
  endif()

  set(${out_startup_file} "${startup_file}" PARENT_SCOPE)
  set(${out_system_file} "${system_file}" PARENT_SCOPE)
endfunction()

function(nrf5_get_softdevice_data sdk_path sdk_version target sd_variant out_sd_hex_file_path out_sd_flags)
  # If we have blank or mbr sd_variant then continue...
  if(sd_variant MATCHES "^(blank|mbr)$")
    return()
  endif()

  # Get more info about the target
  nrf5_split_target(${target} target_family target_variant target_group)

  # Check supported SD.
  set(softdevices_15.3.0 s112 s132 s140 s212 s312 s332 s340)
  set(softdevices_16.0.0 s112 s113 s132 s140 s212 s312 s332 s340)

  list(FIND softdevices_${sdk_version} ${sd_variant} sd_variant_supported)
  if (sd_variant_supported EQUAL -1)
    message(FATAL_ERROR "SoftDevice variant ${sd_variant} is not supported in SDK ${sdk_version}")
  endif()

  # Supported targets
  set(supports_15.3.0_s112 nrf52810 nrf52811 nrf52832)
  set(supports_15.3.0_s132 nrf52832)
  set(supports_15.3.0_s140 nrf52840)
  set(supports_15.3.0_s212 nrf52810 nrf52832)
  set(supports_15.3.0_s312 nrf52810)
  set(supports_15.3.0_s332 nrf52832)
  set(supports_15.3.0_s340 nrf52840)

  set(supports_16.0.0_s112 nrf52810 nrf52811 nrf52820 nrf52832)
  set(supports_16.0.0_s113 nrf52810 nrf52811 nrf52832 nrf52833 nrf52840)
  set(supports_16.0.0_s132 nrf52832)
  set(supports_16.0.0_s140 nrf52811 nrf52820 nrf52833 nrf52840)
  set(supports_16.0.0_s212 nrf52810 nrf52832)
  set(supports_16.0.0_s312 nrf52810)
  set(supports_16.0.0_s332 nrf52832)
  set(supports_16.0.0_s340 nrf52840)

  list(FIND supports_${sdk_version}_${sd_variant} ${target_group} sd_target_supported)
  if (sd_target_supported EQUAL -1)
    message(FATAL_ERROR "SoftDevice variant ${sd_variant} is not supported on ${target_group}")
  endif()

  # Check if headers are preset.
  set(sd_header_path_pattern "${sdk_path}/components/softdevice/${sd_variant}/headers/*.h")
  file(GLOB sd_headers "${sd_header_path_pattern}")
  list(LENGTH sd_headers sd_headers_count)
  if(sd_headers_count EQUAL 0)
    message(FATAL_ERROR "SoftDevice header files missing inside: ${sd_header_path_pattern}")
  endif()

  # Get information about SoftDevice.
  set(sd_key_version 0)
  set(sd_key_use_ble 1)
  set(sd_key_use_ant 2)

  set(softdevice_15.3.0_s112 6.1.1 YES NO)
  set(softdevice_15.3.0_s132 6.1.1 YES NO)
  set(softdevice_15.3.0_s140 6.1.1 YES NO)
  set(softdevice_15.3.0_s212 6.1.1 NO YES)
  set(softdevice_15.3.0_s312 6.1.1 YES YES)
  set(softdevice_15.3.0_s332 6.1.1 YES YES)
  set(softdevice_15.3.0_s340 6.1.1 YES YES)

  set(softdevice_16.0.0_s112 7.0.1 YES NO)
  set(softdevice_16.0.0_s113 7.0.1 YES NO)
  set(softdevice_16.0.0_s132 7.0.1 YES NO)
  set(softdevice_16.0.0_s140 7.0.1 YES NO)
  set(softdevice_16.0.0_s212 6.1.1 NO YES)
  set(softdevice_16.0.0_s312 6.1.1 YES YES)
  set(softdevice_16.0.0_s332 6.1.1 YES YES)
  set(softdevice_16.0.0_s340 6.1.1 YES YES)

  list(GET softdevice_${sdk_version}_${sd_variant} ${sd_key_version} sd_version)
  list(GET softdevice_${sdk_version}_${sd_variant} ${sd_key_use_ble} sd_use_ble)
  list(GET softdevice_${sdk_version}_${sd_variant} ${sd_key_use_ant} sd_use_ant)
  string(REGEX REPLACE "\.[0-9]\.[0-9]" "" sd_version_major ${sd_version})

  # Check if hex file is present.
  set(sd_hex_file_path_pattern "${sdk_path}/components/softdevice/${sd_variant}/hex/*${sd_variant}*${sd_version}*.hex")
  file(GLOB hex_file_path ${sd_hex_file_path_pattern})
  if (NOT hex_file_path)
    message(FATAL_ERROR "Cannot find SoftDevice HEX file inside SDK: ${sd_hex_file_path_pattern}")
  endif()

  # Add flags
  string(TOUPPER ${sd_variant} sd_variant_upper)
  set(sd_flags "-DSOFTDEVICE_PRESENT" "-D${sd_variant_upper}")
  if(${sd_use_ble})
    list(APPEND sd_flags "-DNRF_SD_BLE_API_VERSION=${sd_version_major}" "-DBLE_STACK_SUPPORT_REQD")
  endif()

  if(${sd_use_ant})
    list(APPEND sd_flags "-DANT_STACK_SUPPORT_REQD")
  endif()

  # Set output variables
  set(${out_sd_hex_file_path} "${hex_file_path}" PARENT_SCOPE)
  set(${out_sd_flags} ${sd_flags} PARENT_SCOPE)

endfunction()

function(nrf5_get_mbr_data sdk_path sdk_version target_short out_mbr_hex_file out_mbr_flags)
  if(NRF5_SDK_VERSION VERSION_GREATER_EQUAL 16.0.0)
    set(mbr_hex_pattern INTERFACE "${NRF5_SDK_PATH}/components/softdevice/mbr/hex/*.hex")
  else()
    set(mbr_hex_pattern INTERFACE "${NRF5_SDK_PATH}/components/softdevice/mbr/${target_short}/hex/*.hex")
  endif()

  nrf5_find_file_path_with_patterns("${mbr_hex_pattern}" mbr_hex_file)
  if(NOT mbr_hex_file)
    message(FATAL_ERROR "Cannot find MBR HEX file for the ${target_short} target inside SDK: ${mbr_hex_pattern}")
  endif()

  set(${out_mbr_hex_file} ${mbr_hex_file} PARENT_SCOPE)
  set(${out_mbr_flags} "-DMBR_PRESENT" PARENT_SCOPE)

endfunction()
