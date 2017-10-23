#!/usr/bin/env bash
set -e

projectroot="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/..
artifactsdir=$(mktemp -d "${TMPDIR:-/tmp/}artifacts.XXXXXXXXXXXX")

function banner() {
    sep="---------------------------------------------------------------------"
    echo $sep
    echo $@
    echo $sep
}

function build() {
    local docker_image="$1"
    local srcdir="$2"
    local artifactsdir=$3
    local build_script="$4"

    banner "Build artifacts using ${docker_image} docker image"
    docker run --rm -it -v ${srcdir}:/src:ro \
                        -v ${artifactsdir}:/artifacts \
                        ${docker_image} ${build_script}

    local number_of_files=$(find ${artifactsdir} -type f | wc -l)
    banner "${number_of_files} build artifact(s) in ${artifactsdir}"
    ls ${artifactsdir}
    banner "Done"
}

function run_test() {
    local docker_image="$1"
    local input="$2"
    local output=$3
    local script="$4"

    banner "Running test using ${docker_image} docker image"
    docker run --rm -it -v ${input}:/input:ro \
                        -v ${output}:/output \
                        ${docker_image} ${script}
    banner "Done"
}


build cmake-msp430 ${projectroot}/src/msp430 ${artifactsdir}/msp /src/build.sh
build cmake-avr    ${projectroot}/src/avr    ${artifactsdir}/avr /src/build.sh

run_test cmake-simavr  ${artifactsdir}/avr ${artifactsdir}/avr/test_results /input/test.sh


