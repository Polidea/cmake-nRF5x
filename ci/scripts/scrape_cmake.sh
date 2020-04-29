#!/bin/bash

set -e

source "${BASH_SOURCE%/*}/common/consts.sh"
source "${BASH_SOURCE%/*}/common/check_deps.sh"

mkdir -p "$GENERATED_DIR"

for sdk in `ls -d $CMAKE_DIR/*`; do
    files="$files $(find "${sdk}" -regex ".*\.cmake")"
done

echo "$files" | python3 -B "${BASH_SOURCE%/*}/python/scrape_cmake.py" --output "$GENERATED_CMAKE_LIBRARIES"