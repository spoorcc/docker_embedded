#!/usr/bin/env bash
set -e

projectroot="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/..

function banner() {
    sep="---------------------------------------------------------------------"
    echo $sep
    echo $@
    echo $sep
}

function build() {
    docker_image="$1"
    srcdir="$2"
    artifactsdir=$3
    build_script="$4"

    banner "Build artifacts using ${docker_image} docker image"
    docker run --rm -it -v ${srcdir}:/src:ro \
                        -v ${artifactsdir}:/artifacts \
                        ${docker_image} ${build_script}

    number_of_files=$(find ${artifactsdir} -type f | wc -l)
    banner "${number_of_files} build artifact(s) in ${artifactsdir}"
    ls ${artifactsdir}
    banner "Done"
}

artifactsdir=$(mktemp -d "${TMPDIR:-/tmp/}artifacts.XXXXXXXXXXXX")


build cmake-msp430 "${projectroot}/src" "${artifactsdir}" "/src/build.sh"




