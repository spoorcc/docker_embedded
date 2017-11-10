FROM ubuntu
ARG SDCC_VERSION="3.6.0"

MAINTAINER Ben Spoor

# Get all the dependencies
RUN apt-get -qq update && \
    apt-get -qq install -y wget bzip2 cmake

#RUN apt-get -qq install -y sdcc

# From source install && cleanup
RUN apt-get -qq update && \
    apt-get -qq install -y \
    bison flex build-essential texinfo g++ libboost-dev \
    && wget --quiet -O sdcc.tar.bz2 https://downloads.sourceforge.net/project/sdcc/sdcc/3.6.0/sdcc-src-3.6.0.tar.bz2 \
    && tar -xvjf sdcc.tar.bz2 \
    && cd sdcc-3.6.0/ \
    && ./configure --disable-pic14-port --disable-pic16-port \
    && make \
    && make install \
    && apt-get purge -y bison flex build-essential texinfo g++ \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && cd .. && rm -rf ./sdcc-3.6.0/ \
    && rm sdcc.tar.bz2
