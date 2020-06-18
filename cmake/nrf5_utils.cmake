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

function(nrf5_split_target target out_target_family out_target_variant out_target_group)
  string(REGEX REPLACE "_[a-z]+" "" target_group ${target})
  string(REGEX REPLACE "[a-z0-9]+_" "" target_variant ${target})
  string(REGEX MATCH "nrf[0-9][0-9]" target_family ${target})
  set(${out_target_family} ${target_family} PARENT_SCOPE)
  set(${out_target_variant} ${target_variant} PARENT_SCOPE)
  set(${out_target_group} ${target_group} PARENT_SCOPE)
endfunction()

function(nrf5_find_file_path_with_patterns file_path_patterns_list out_file_path)
  foreach(file_path_pattern ${file_path_patterns_list})
    file(GLOB file_path_candidates "${file_path_pattern}")
    list(LENGTH file_path_candidates candidates_count)
    if(${candidates_count} GREATER_EQUAL 1)
      list(GET file_path_candidates 0 file_path_candidate)
      if(file_path_candidate)
        set(${out_file_path} ${file_path_candidate} PARENT_SCOPE)
        return()
      endif()
    endif()
  endforeach()
endfunction()

function(nrf5_target_link_groups target access)
  foreach(group ${ARGN})
    string(TOUPPER ${group} group_upper)
    list(APPEND dependencies ${NRF5_GROUP_${group_upper}_DEPENDENCIES})
  endforeach()
  list(REMOVE_DUPLICATES dependencies)
  get_target_property(target_dependecies ${target} LINK_LIBRARIES)
  list(REMOVE_ITEM dependencies ${target_dependecies})
  target_link_libraries(${target} ${access} ${dependencies})
endfunction()

function(nrf5_target_link_libraries target access)
  foreach(library ${ARGN})
    string(TOUPPER ${library} library_upper)
    list(APPEND dependencies ${NRF5_LIBRARY_${library_upper}_DEPENDENCIES})
  endforeach()
  list(REMOVE_DUPLICATES dependencies)
  get_target_property(target_dependecies ${target} LINK_LIBRARIES)
  list(REMOVE_ITEM dependencies ${target_dependecies})
  target_link_libraries(${target} ${access} ${dependencies})
endfunction()
