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

function(nrf5_validate_sdk sdk_path out_sdk_version)
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

function(nrf5_validate_board sdk_version board out_target out_define)
  # Information about the board. In order:
  # * Board target
  # * Board define
  # * Min SDK version
  # * Max SDK version

  set(target_key 0)
  set(define_key 1)
  set(min_sdk_key 2)
  set(max_sdk_key 3)

  set(board_nrf6310       "nrf51822" "BOARD_NRF6310"  "15.3.0" "16.0.0")
  set(board_pca10000      "nrf51822" "BOARD_PCA10000" "15.3.0" "16.0.0")
  set(board_pca10001      "nrf51822" "BOARD_PCA10001" "15.3.0" "16.0.0")
  set(board_pca10002      "nrf51422" "BOARD_PCA10002" "15.3.0" "16.0.0")
  set(board_pca10003      "nrf51422" "BOARD_PCA10003" "15.3.0" "16.0.0")
  set(board_pca20006      "nrf51822" "BOARD_PCA20006" "15.3.0" "16.0.0")
  set(board_pca10028      "nrf51422" "BOARD_PCA10028" "15.3.0" "16.0.0")
  set(board_pca10031      "nrf51422" "BOARD_PCA10031" "15.3.0" "16.0.0")
  set(board_pca10036      "nrf52832" "BOARD_PCA10036" "15.3.0" "16.0.0")
  set(board_pca10040      "nrf52832" "BOARD_PCA10040" "15.3.0" "16.0.0")
  set(board_pca10040e     "nrf52810" "BOARD_PCA10040" "15.3.0" "16.0.0")
  set(board_pca10056      "nrf52840" "BOARD_PCA10056" "15.3.0" "16.0.0")
  set(board_pca10056e     "nrf52811" "BOARD_PCA10056" "15.3.0" "16.0.0")
  set(board_pca10100      "nrf52833" "BOARD_PCA10100" "15.3.0" "15.3.0")
  set(board_pca20020      "nrf52832" "BOARD_PCA20020" "15.3.0" "16.0.0")
  set(board_pca10059      "nrf52840" "BOARD_PCA10059" "15.3.0" "16.0.0")
  set(board_wt51822       "nrf51822" "BOARD_WT51822"  "15.3.0" "16.0.0")
  set(board_n5dk1         "nrf51422" "BOARD_N5DK1"    "15.3.0" "16.0.0")
  set(board_d52dk1        "nrf52832" "BOARD_D52DK1"   "15.3.0" "16.0.0")
  set(board_arduinoprimo  "nrf52832" "BOARD_ARDUINO_PRIMO" "15.3.0" "16.0.0")
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
