#!/bin/bash

set -e

source "${BASH_SOURCE%/*}/common/consts.sh"
source "${BASH_SOURCE%/*}/common/check_deps.sh"
source "${BASH_SOURCE%/*}/common/python.sh"

python3 "${PYTHON_DIR}/generate_cmake.py" \
    --supported_sdks "15.3.0" "16.0.0" \
    --lib_template "${LIBRARIES_CMAKE_TEMPLATE_FILE}" \
    --group_template "${LIBRARIES_CMAKE_GROUPS_TEMPLATE_FILE}" \
    --input_dir "${LIBRARIES_DIR}" \
    --output_dir "${CMAKE_DIR}"
