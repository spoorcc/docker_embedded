FROM ubuntu

MAINTAINER Ben Spoor

# From source install && cleanup
RUN apt-get -qq update && \
    apt-get -qq install -y \
    git \
    build-essential \
    libusb-1.0-0-dev \
    libtool \
    autoconf \
    automake \
    texinfo \
    make \
    pkg-config \
    && git clone https://git.code.sf.net/p/openocd/code openocd-code \
    && cd openocd-code \
    && git fetch http://openocd.zylin.com/openocd refs/changes/53/3953/10 && git checkout FETCH_HEAD \
    && ./bootstrap \
    && ./configure \
    && make \
    && make install
