#!/bin/bash

set -e

source "${BASH_SOURCE%/*}/common/consts.sh"
source "${BASH_SOURCE%/*}/common/download.sh"
source "${BASH_SOURCE%/*}/common/utils.sh"

# Prepare python
invoke_py3 -m venv "${PYTHON_VENV_DIR}"
source "${PYTHON_VENV_SCRIPT}"
invoke_pip3 install -r "${PYTHON_DIR}/requirements.txt"

# List of SDKs to download
sdks=( "15.3.0" "16.0.0" )

for sdk in "${sdks[@]}"; do
    if [[ ! -d "$SDKS_DIR/$sdk" ]]; then
        echo "Downloading SDK $sdk..."
        download_sdk "$sdk" "$SDKS_DIR/$sdk"
    fi

    # Clone uECC library if needed
    if [[ ! -d "$SDKS_DIR/$sdk/external/micro-ecc/micro-ecc" ]]; then
        echo "Cloning uECC lib into SDK ver $sdk..."
        pushd "$SDKS_DIR/$sdk/external/micro-ecc"
            git clone "https://github.com/kmackay/micro-ecc.git"
        popd
    fi
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
