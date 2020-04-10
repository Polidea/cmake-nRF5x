#!/bin/bash

source "${BASH_SOURCE%/*}/utils.sh"

# Global definitions
ROOT_LOCAL_DIR="${BASH_SOURCE%/*}/../../.."
ROOT_DIR="$(absolute $ROOT_LOCAL_DIR)"
BUILD_DIR="$ROOT_DIR/build"
CMAKE_DIR="$ROOT_DIR/cmake"
CI_DIR="$ROOT_DIR/ci"
EXAMPLES_DIR="$CI_DIR/examples"
TOOLCHAINS_DIR="$CI_DIR/toolchains"
TOOLS_DIR="$CI_DIR/tools"
NRFJPROG_DIR="$TOOLS_DIR/nrf/nrfjprog/"
MERGEHEX_DIR="$TOOLS_DIR/nrf/mergehex/"
SDKS_DIR="$CI_DIR/sdks"
VARIANT_REGEXP="(pca[0-9]{5})_(s[0-9]{3})"