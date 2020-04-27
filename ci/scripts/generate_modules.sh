#!/bin/bash

set -e

source "${BASH_SOURCE%/*}/common/consts.sh"
source "${BASH_SOURCE%/*}/common/check_deps.sh"

if [[ ! -f "$DATA_ALL_EXAMPLES" ]]; then
    echo "$DATA_ALL_EXAMPLES doesn't exist, create via scrape_makefiles.sh"
    exit 1
fi

python3 -B "${BASH_SOURCE%/*}/python/generate_modules.py" \
    --all_examples "$DATA_ALL_EXAMPLES" \
    --builtin_modules "$DATA_MODULES_BUILTIN" \
    --cmake_modules  "$DATA_MODULES_CMAKE" \
    --output "$DATA_MODULES"