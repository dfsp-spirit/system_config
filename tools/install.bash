#!/bin/bash

TARGET_DIR="${HOME}/bin/"

if [ -n "$1" ]; then
    TARGET_DIR="$1"
fi

if [ -d "${TARGET_DIR}" ]; then
    ## Install GRID
    echo "Installing GRID into '${TARGET_DIR}'."
    cp grid/grid.bash "${TARGET_DIR}"
else
    echo "ERROR: Target directory '${TARGET_DIR}' not found. Not installing anything."
fi
