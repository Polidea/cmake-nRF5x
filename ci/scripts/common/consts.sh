#!/bin/bash

source "${BASH_SOURCE%/*}/utils.sh"

# Global definitions
ROOT_LOCAL_DIR="${BASH_SOURCE%/*}/../../.."
ROOT_DIR="$(absolute $ROOT_LOCAL_DIR)"
BUILD_DIR="$ROOT_DIR/build"
CMAKE_DIR="$ROOT_DIR/cmake"
CI_DIR="$ROOT_DIR/ci"
SCRIPTS_DIR="$CI_DIR/scripts"
PYTHON_DIR="$SCRIPTS_DIR/python"
PYTHON_VENV_DIR="$PYTHON_DIR/.venv"
GENERATED_DIR="$CI_DIR/generated"
LIBRARIES_DIR="$CI_DIR/libraries"
EXAMPLES_DIR="$CI_DIR/examples"
TOOLCHAINS_DIR="$CI_DIR/toolchains"
TOOLS_DIR="$CI_DIR/tools"
NRFJPROG_DIR="$TOOLS_DIR/nrf/nrfjprog/"
MERGEHEX_DIR="$TOOLS_DIR/nrf/mergehex/"
SDKS_DIR="$CI_DIR/sdks"

# Regexp
VARIANT_REGEXP="(pca[0-9]{5})_(s[0-9]{3})"

# Generated files
PYTHON_VENV_SCRIPT="$PYTHON_VENV_DIR/bin/activate"
GENERATED_EXAMPLES="$GENERATED_DIR/examples.json"
GENERATED_LIBRARIES="$GENERATED_DIR/libraries.json"
GENERATED_CMAKE_LIBRARIES="$GENERATED_DIR/cmake_libraries.json"