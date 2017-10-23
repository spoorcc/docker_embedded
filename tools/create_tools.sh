#!/usr/bin/env bash
set -e

projectroot="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/..

for DIRECTORY in *; do
    if [ -d "${DIRECTORY}" ]; then
        docker build -t ${DIRECTORY} $projectroot/tools/${DIRECTORY}
    fi
done
