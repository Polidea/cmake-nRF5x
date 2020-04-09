#!/bin/bash

# Include
source "$(dirname $0)/functions/utils.sh"
source "$(dirname $0)/functions/consts.sh"
source "$(dirname $0)/functions/download.sh"

# List of SDKs to download
sdks=( "15.3.0" "16.0.0" )

for sdk in "${sdks[@]}"; do
    if [[ -d "$SDKS_DIR/$sdk" ]]; then
        echo "SDK $sdk is already present, skipping..."
        continue
    fi
    download_sdk "$sdk" "$SDKS_DIR/$sdk"
done

# Download toolchains
if [[ -d "$TOOLCHAINS_DIR/gcc" ]]; then
    echo "GCC toolchain already present, skipping..."
else
    download_gcc_toolchain "$TOOLCHAINS_DIR/gcc"
fi