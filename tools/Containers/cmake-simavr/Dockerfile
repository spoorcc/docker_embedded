FROM ubuntu

MAINTAINER Ben Spoor

RUN apt-get -qq update

RUN apt-get -qq install -y cmake gcc-avr binutils-avr avr-libc

# Glut is graphical library which is a dependency for some of the examples
# These examples are in turn dependency for install, no way to turn it off
RUN apt-get -qq install -y git libelf-dev freeglut3-dev pkg-config

RUN git clone https://github.com/buserror/simavr.git

RUN make -C simavr && \
    make -C simavr install RELEASE=1

ENV LD_LIBRARY_PATH="/usr/local/lib:${LD_LIBRARY_PATH}"
ENV PATH="/simavr/simavr:${PATH}"
