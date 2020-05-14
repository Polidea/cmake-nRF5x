#!/bin/bash

set -e

source "${BASH_SOURCE%/*}/common/consts.sh"
source "${BASH_SOURCE%/*}/common/check_deps.sh"
source "${BASH_SOURCE%/*}/common/python.sh"
source "${BASH_SOURCE%/*}/common/utils.sh"

invoke_py3 "${PYTHON_DIR}/run_tests.py"