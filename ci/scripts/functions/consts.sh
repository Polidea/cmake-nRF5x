#!/bin/bash

ROOT_LOCAL_DIR="$(dirname $0)/../.."
ROOT_DIR="$(absolute $ROOT_LOCAL_DIR)"
CMAKE_DIR="$ROOT_DIR/cmake"
CI_DIR="$ROOT_DIR/ci"
EXAMPLES_DIR="$CI_DIR/examples"
TOOLCHAINS_DIR="$CI_DIR/toolchains"
SDKS_DIR="$CI_DIR/sdks"