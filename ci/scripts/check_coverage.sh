#!/bin/bash

set -e

source "${BASH_SOURCE%/*}/common/consts.sh"
source "${BASH_SOURCE%/*}/common/check_deps.sh"
source "${BASH_SOURCE%/*}/common/python.sh"

python3 "${PYTHON_DIR}/check_coverage.py" \
    --generated_examples "${GENERATED_EXAMPLES}" \
    --generated_libraries "${GENERATED_LIBRARIES}" \
    --examples_dir "${EXAMPLES_DIR}" \
    --libraries_tests_dir "${LIBRARIES_TESTS_DIR}" \
    $@