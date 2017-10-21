# Docker Embedded
[![Build Status](https://travis-ci.org/spoorcc/docker_embedded.svg?branch=master)](https://travis-ci.org/spoorcc/docker_embedded)

Example of how to use docker for embedded development This example uses CMake
to compile a simple target for MSP430 in a docker container.

## Usage

Create the tooling (docker images) using
```
./tools/create_tools.sh
```

Use the tooling with
```
./tools/use_tools.sh
```

## Local Continuous Integration

When developing it is nice to build on after every save in your docker container.

* Make sure `inotify` is installed
* Source `./tools/local_ci.sh` in a terminal window
* run `local_ci` command
* Each time a file is saved in the `src` directory the docker images will be fired automatically


