FROM ubuntu

MAINTAINER Ben Spoor

# From source install && cleanup
RUN apt-get -qq update && \
    apt-get -qq install -y \
    git \
    build-essential \
    libusb-1.0-0-dev \
    pkg-config \
    && git clone https://github.com/vdudouyt/stm8flash.git \
    && make -C stm8flash \
    && make install -C stm8flash \
    && apt-get purge -y git build-essential pkg-config \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf stm8flash
