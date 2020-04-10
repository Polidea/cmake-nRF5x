#!/bin/bash

source "${BASH_SOURCE%/*}/common/consts.sh"
source "${BASH_SOURCE%/*}/common/download.sh"

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

# Download nRF tools
if [[ -d "$TOOLS_DIR/nrf" ]]; then
    echo "nRF Tools already present, skipping..."
else
    download_nrf_tools "$TOOLS_DIR/nrf"
fi