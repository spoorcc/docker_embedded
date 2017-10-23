#!/usr/bin/env bash
set -e

projectroot="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/..

for DIRECTORY in $projectroot/tools/*; do
    if [ -d "${DIRECTORY}" ]; then
        docker build -t $(basename ${DIRECTORY}) ${DIRECTORY}
    fi
done
