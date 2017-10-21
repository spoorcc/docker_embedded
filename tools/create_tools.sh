#!/usr/bin/env bash
set -e

projectroot="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/..

docker build -t cmake_msp $projectroot/tools
