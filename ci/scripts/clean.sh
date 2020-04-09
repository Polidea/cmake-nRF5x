#!/bin/bash

# Include
source "$(dirname $0)/functions/utils.sh"
source "$(dirname $0)/functions/consts.sh"

# Remove SDKs
echo "Removing: $SDKS_DIR"
rm -rf "$SDKS_DIR"

# Remove Toolchains
echo "Removing: $TOOLCHAINS_DIR"
rm -rf "$TOOLCHAINS_DIR"