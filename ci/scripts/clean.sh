#!/bin/bash

# Include
source "${BASH_SOURCE%/*}/common/consts.sh"

# Remove builds
echo "Removing: $BUILD_DIR"
rm -rf "$BUILD_DIR"

# Remove SDKs
echo "Removing: $SDKS_DIR"
rm -rf "$SDKS_DIR"

# Remove Toolchains
echo "Removing: $TOOLCHAINS_DIR"
rm -rf "$TOOLCHAINS_DIR"

# Remove Tools
echo "Removing: $TOOLS_DIR"
rm -rf "$TOOLS_DIR"