#!/usr/bin/env bash
set -e

mkdir -p /bld

cd /bld
cmake /src
make

cp *.hex /artifacts
cp *.elf /artifacts
cp *.map /artifacts
cp /src/test.sh /artifacts
