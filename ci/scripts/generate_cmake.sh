#!/bin/bash

set -e

source "${BASH_SOURCE%/*}/common/consts.sh"
source "${BASH_SOURCE%/*}/common/check_deps.sh"
source "${BASH_SOURCE%/*}/common/python.sh"

for file_path in $(find "${LIBRARIES_DIR}" -name "*.json"); do
    file_name="$(basename ${file_path})"
    python3 "${PYTHON_DIR}/generate_cmake.py" \
        --supported_sdks "15.3.0" "16.0.0" \
        --template "${LIBRARIES_CMAKE_TEMPLATE_FILE}" \
        --input "${file_path}" \
        --output "${CMAKE_DIR}/${file_name%.*}.cmake"
done
