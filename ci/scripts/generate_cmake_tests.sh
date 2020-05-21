#!/bin/bash

set -e

source "${BASH_SOURCE%/*}/common/consts.sh"
source "${BASH_SOURCE%/*}/common/check_deps.sh"
source "${BASH_SOURCE%/*}/common/python.sh"

python3 "${PYTHON_DIR}/generate_cmake_tests.py" \
    --supported_sdks "15.3.0" "16.0.0" \
    --template "${LIBRARIES_CMAKE_TESTS_TEMPLATE_FILE}" \
    --input_dir "${LIBRARIES_DIR}" \
    --output_dir "${LIBRARIES_TESTS_DIR}"
