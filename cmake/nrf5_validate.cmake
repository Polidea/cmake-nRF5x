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

function(nrf5_validate_sdk sdk_path sdk_version)
    if(NOT EXISTS ${sdk_path})
        message(FATAL_ERROR "Specified nRF SDK doesn't exist: ${sdk_path}")
    endif()
    set(release_notes_path "${sdk_path}/documentation/release_notes.txt")
    if (NOT EXISTS "${release_notes_path}")
        message(FATAL_ERROR "Cannot find release notes in following SDK: ${release_notes_path}")
    endif()
    file(STRINGS "${release_notes_path}" release_notes LIMIT_COUNT 1)
    string(REGEX MATCH "[0-9]+\.[0-9]+\.[0-9]+" version "${release_notes}")
    set(${sdk_version} ${version} PARENT_SCOPE)
endfunction()

function(nrf5_validate_sdk_version sdk_version)
    set(supported_sdk_versions "15.3.0" "16.0.0")
    list(FIND supported_sdk_versions ${sdk_version} sdk_version_index)
    if(sdk_version_index EQUAL -1)
        message(FATAL_ERROR "Provided nRF SDK version ${sdk_version} is not supported, try these: ${supported_sdk_versions}")
    endif()
endfunction()

function(nrf5_validate_board sdk_version board target)
  # List of all supported boards, append only
  set (supported_boards 
    nrf6310 
    pca10000 
    pca10001 
    pca10002 
    pca10003 
    pca10028
    pca10031
    pca10036 
    pca10040 
    pca10056 
    pca10059 
    pca20006
    d52dk1 
    wt51822
  )

  # Minimum SDK version supported by the board, append only
  set (boards_min_ver
    "15.3.0" # nrf6310 
    "15.3.0" # pca10000 
    "15.3.0" # pca10001 
    "15.3.0" # pca10002 
    "15.3.0" # pca10003 
    "15.3.0" # pca10028
    "15.3.0" # pca10031
    "15.3.0" # pca10036 
    "15.3.0" # pca10040 
    "15.3.0" # pca10056 
    "15.3.0" # pca10059 
    "15.3.0" # pca20006
    "15.3.0" # d52dk1 
    "15.3.0" # wt51822
  )

  # Maximum SDK version supported by the board, append only
  set (boards_max_ver
    "16.0.0" # nrf6310 
    "16.0.0" # pca10000 
    "16.0.0" # pca10001 
    "16.0.0" # pca10002 
    "16.0.0" # pca10003 
    "16.0.0" # pca10028
    "16.0.0" # pca10031
    "16.0.0" # pca10036 
    "16.0.0" # pca10040 
    "16.0.0" # pca10056 
    "16.0.0" # pca10059 
    "16.0.0" # pca20006
    "16.0.0" # d52dk1 
    "16.0.0" # wt51822
  )

  # Board target, append only
  set (boards_target
    "nrf51822" # nrf6310
    "nrf51822" # pca10000
    "nrf51822" # pca10001
    "nrf51422" # pca10002
    "nrf51422" # pca10003
    "nrf51422" # pca10028
    "nrf51822" # pca10031
    "nrf52832" # pca10036
    "nrf52832" # pca10040
    "nrf52840" # pca10056 
    "nrf52840" # pca10059 
    "nrf51822" # pca20006
    "nrf52832" # d52dk1 
    "nrf51822" # wt51822
  )

  list(FIND supported_boards ${board} index)
  if(index EQUAL -1)
    message(FATAL_ERROR "Unsupported nRF board: ${board}")
  endif()

  list(GET boards_min_ver ${index} board_min_ver)
  list(GET boards_max_ver ${index} board_max_ver)  
  if((sdk_version VERSION_LESS board_min_ver) OR (sdk_version VERSION_GREATER board_max_ver))
    message(FATAL_ERROR "Unsupported nRF board ${board} in version ${sdk_version}")
  endif()

  list(GET boards_target ${index} board_target)
  set(${target} ${board_target} PARENT_SCOPE)

endfunction()