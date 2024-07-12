#!/bin/bash
PYTHON_CMD="python"

if ! command -v python &> /dev/null
then
    if ! command -v python3 &> /dev/null
    then
        echo "python could not be found."
        exit 1
    else
        PYTHON_CMD="python3"
    fi
fi

$PYTHON_CMD ./scripts/init.py
