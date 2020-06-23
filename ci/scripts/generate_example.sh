#!/bin/bash

set -e

source "${BASH_SOURCE%/*}/common/consts.sh"
source "${BASH_SOURCE%/*}/common/check_deps.sh"
source "${BASH_SOURCE%/*}/common/python.sh"
source "${BASH_SOURCE%/*}/common/utils.sh"

if [[ ! -f "$GENERATED_EXAMPLES" ]]; then
    echo "$GENERATED_EXAMPLES doesn't exist, create via scrape_makefiles.sh"
    exit 1
fi

if [[ ! -f "$GENERATED_LIBRARIES" ]]; then
    echo "$GENERATED_LIBRARIES doesn't exist, create via generate_libraries.sh"
    exit 1
fi

invoke_py3 "${PYTHON_DIR}/generate_example.py" \
    --examples "$GENERATED_EXAMPLES" \
    --libraries "$GENERATED_LIBRARIES" \
    --examples_dir "$EXAMPLES_DIR" \
    --example_template "$EXAMPLE_CMAKE_TEMPLATE_FILE" \
    $@