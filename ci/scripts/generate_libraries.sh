#!/bin/bash

set -e

source "${BASH_SOURCE%/*}/common/consts.sh"
source "${BASH_SOURCE%/*}/common/check_deps.sh"

if [[ ! -f "$GENERATED_EXAMPLES" ]]; then
    echo "$GENERATED_EXAMPLES doesn't exist, create via scrape_makefiles.sh"
    exit 1
fi

python3 -B "${BASH_SOURCE%/*}/python/generate_libraries.py" \
    --examples "$GENERATED_EXAMPLES" \
    --libraries "$(find $LIBRARIES_DIR -name "*.json")" \
    --output "$GENERATED_LIBRARIES"