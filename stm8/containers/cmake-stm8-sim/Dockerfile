FROM ubuntu
ARG SDCC_VERSION="3.6.0"

MAINTAINER Ben Spoor

# Get all the dependencies
RUN apt-get -qq update && \
    apt-get -qq install -y wget bzip2 cmake

RUN apt-get -qq install -y sdcc-ucsim
