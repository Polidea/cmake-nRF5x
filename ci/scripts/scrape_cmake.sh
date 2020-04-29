#!/bin/bash

set -e

source "${BASH_SOURCE%/*}/common/consts.sh"
source "${BASH_SOURCE%/*}/common/check_deps.sh"
source "${BASH_SOURCE%/*}/common/python.sh"

mkdir -p "$GENERATED_DIR"

for file_path in $(find "${CMAKE_DIR}" -name "*.cmake"); do
    file_name="$(basename ${file_path})"
    python3 "${PYTHON_DIR}/scrape_cmake.py" \
        --input "${file_path}" \
        --output "${GENERATED_DIR}/${file_name%.*}.json"
done