function banner() {
    sep="---------------------------------------------------------------------"
    echo $sep
    echo $@
    echo $sep
}

projectroot="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/..

artifactsdir=$(mktemp -d "${TMPDIR:-/tmp/}artifacts.XXXXXXXXXXXX")

banner "Build artifacts using MSP430 Cmake docker image"
docker run --rm -it -v ${projectroot}/src:/src:ro -v ${artifactsdir}:/artifacts cmake_msp

number_of_files=$(find ${artifactsdir} -type f | wc -l)
banner "${number_of_files} build artifact(s) in ${artifactsdir}"
ls ${artifactsdir}
banner "Done"


