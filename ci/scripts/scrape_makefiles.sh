#!/bin/bash

source "${BASH_SOURCE%/*}/common/consts.sh"
source "${BASH_SOURCE%/*}/common/check_deps.sh"

mkdir -p "$DATA_DIR"

for sdk in `ls -d $SDKS_DIR/*`; do
    files="$files $(find "${sdk}" -regex ".*/examples/.*/armgcc/Makefile")"
done

echo "$files" | python3 -B "${BASH_SOURCE%/*}/python/scrape_makefiles.py" --output "$DATA_ALL_EXAMPLES"