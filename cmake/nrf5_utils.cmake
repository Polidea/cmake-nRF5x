# MIT License

# Copyright (c) 2019 Polidea

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

function(nrf5_validate_softdevice_variant softdevice_variant)
  set(supported_sd_variants s112 s113 s132 s140 s212 s312 s332 s340)  
  string(TOLOWER ${softdevice_variant} sd_variant_lower)
  list(FIND supported_sd_variants ${sd_variant_lower} index)

  if(index EQUAL -1)
    message(FATAL_ERROR "Invalid SoftDevice variant: ${softdevice_variant}")
  endif()
endfunction()

function(nrf5_get_mdk_postfix out_postfix target)
  if(target STREQUAL "nrf52810")
    set(${out_postfix} "nrf52810" PARENT_SCOPE)
  elseif(target STREQUAL "nrf52832")
    set(${out_postfix} "nrf52" PARENT_SCOPE)
  elseif(target STREQUAL "nrf52840")
    set(${out_postfix} "nrf52840" PARENT_SCOPE)
  else()
    message(FATAL_ERROR "Invalid target passed to nrf5_target_system_postfix() function")
  endif()
endfunction()

function(nrf5_get_device_name out_device_name target)
  # There are two nRF52832 SoC variants available with varying Flash and RAM sizes. Currently, only XXAA variant is supported.
  if(target STREQUAL "nrf52832")
    message(WARNING "nRF52832 target specified. nRF52832_XXAA variant assumed (512kB Flash / 64kB RAM).")
  endif()

  string(TOUPPER ${target} target_upper)
  set(${out_device_name} "${target_upper}_XXAA" PARENT_SCOPE)
endfunction()

function(nrf5_get_softdevice_variant out_sd_variant target)
  if(target STREQUAL "nrf52810")
    set(${out_sd_variant} "s112" PARENT_SCOPE)
  elseif(target STREQUAL "nrf52832")
   set(${out_sd_variant} "s132" PARENT_SCOPE)
  elseif(target STREQUAL "nrf52840")
    set(${out_sd_variant} "s140" PARENT_SCOPE)
  else()
    message(FATAL_ERROR "Invalid target passed to nrf5_get_softdevice_variant() function")
  endif()
endfunction()

function(nrf5_find_softdevice_file out_softdevice_file search_path softdevice_variant)
  file(GLOB_RECURSE softdevice_file_list LIST_DIRECTORIES false "${search_path}/*${softdevice_variant}*.hex")
  if(softdevice_file_list)
    list(LENGTH softdevice_file_list softdevice_file_list_len)
    if(softdevice_file_list_len GREATER 1)
      message(WARNING "Found multiple matching SoftDevice HEX files: ${softdevice_file_list}")
    endif()

    list(GET softdevice_file_list 0 softdevice_file)
    set(${out_softdevice_file} ${softdevice_file} PARENT_SCOPE)
  endif()
endfunction()
