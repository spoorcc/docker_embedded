FROM ubuntu
ARG GCC_ARM_VERSION="gcc-arm-none-eabi-6-2017-q2-update-linux"

MAINTAINER Ben Spoor

# Get all the dependencies
RUN apt-get -qq update && \
    apt-get -qq install -y wget bzip2

# Get ARM toolchain
RUN wget --quiet -O $GCC_ARM_VERSION.tar.bz2 \
    https://developer.arm.com/-/media/Files/downloads/gnu-rm/6-2017q2/$GCC_ARM_VERSION.tar.bz2

# Install to /opt path
RUN mkdir -p /opt/$GCC_ARM_VERSION && \
    tar jxf $GCC_ARM_VERSION.tar.bz2 -C /opt/$GCC_ARM_VERSION --strip-components=1 && \
    rm $GCC_ARM_VERSION.tar.bz2
RUN ls /opt
ENV PATH="/opt/$GCC_ARM_VERSION/bin:${PATH}"
RUN arm-none-eabi-gcc --version
