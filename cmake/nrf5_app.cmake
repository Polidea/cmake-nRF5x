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

# Scheduler
add_library(nrf5_app_scheduler OBJECT EXCLUDE_FROM_ALL
  "${NRF5_SDK_PATH}/components/libraries/scheduler/app_scheduler.c"
)
target_include_directories(nrf5_app_scheduler PUBLIC
  "${NRF5_SDK_PATH}/components/libraries/util"
  "${NRF5_SDK_PATH}/components/libraries/scheduler"
)
target_link_libraries(nrf5_app_scheduler PUBLIC nrf5_config nrf5_mdk nrf5_soc)
