#!/bin/bash

source "${BASH_SOURCE%/*}/consts.sh"
source "${BASH_SOURCE%/*}/utils.sh"

if [[ ! -f "${PYTHON_VENV_SCRIPT}" ]]; then
    echo "VENV not created. Run prepare.sh script."
    exit 1
fi

chmod +x "${PYTHON_VENV_SCRIPT}"
source "${PYTHON_VENV_SCRIPT}"

echo "Using $(invoke_py3 --version)"