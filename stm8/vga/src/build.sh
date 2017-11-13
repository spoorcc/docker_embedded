#!/usr/bin/env bash
set -e

mkdir -p /bld
cd /bld

cmake /src
make clean
make

cp /bld/vga.* /artifacts
