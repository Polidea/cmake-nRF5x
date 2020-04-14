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

# Check and optionally download nRF tools
if [[ "$OSTYPE" == "cygwin" ]]; then
    # nRF5 Command Line Tools for Windows are available only as an .exe installer; expect the user to install them manually
    echo "Running on Windows (Cygwin), checking the nRF Command Line Tools available from PATH:"

    (check_binary nrfjprog); nrfjprog_found="$?"
    (check_binary mergehex); mergehex_found="$?"

    if [[ "$nrfjprog_found" -ne 0 ]] || [[ "$mergehex_found" -ne 0 ]]; then
        echo "Some of the nRF5 Command Line Tools are missing. Please install the nRF Command Line Tools manually and then re-run this script."
        exit 1
    fi
else
    # Download nRF tools
    if [[ -d "$TOOLS_DIR/nrf" ]]; then
        echo "nRF Tools already present, skipping..."
    else
        download_nrf_tools "$TOOLS_DIR/nrf"
    fi
fi
