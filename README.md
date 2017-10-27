# Docker Embedded
[![Build Status](https://travis-ci.org/spoorcc/docker_embedded.svg?branch=master)](https://travis-ci.org/spoorcc/docker_embedded)

Example of how to use docker for embedded development This example uses CMake
to compile a simple target for MSP430 in a docker container. Next to that,
CMake is also used to create the docker containers and manage the docker runs.

## Usage

```
mkdir -p bld
cd bld
cmake ..
make
```

## Dependencies

* Cmake
* Docker

## Rationale

Continuous integration is very popular right now. Typical implementations for scripting the actions
in pipelines is bash,batch and/or powershell. This is not portable and good tools already exist. 
This project is my endeavour to look at using the correct tool for the correct job.

* Docker is great in having a reproducible set of tooling.
* CMake is great in having a reproducible and portable build.
* CI is great at starting high-level steps and visualizing outcome.

## Local Continuous Integration

When developing it is nice to build on after every save in your docker container.

* Make sure `inotify` is installed
* run `./tools/local_ci.sh` in a terminal window
* Each time a file is saved in the `src` directory the docker images will be fired automatically


