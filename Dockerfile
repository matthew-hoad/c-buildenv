FROM ubuntu

RUN apt-get update && \
    apt-get install -y --reinstall ca-certificates &&\
    apt-get install -y --no-install-recommends git wget curl make \
        gcc \
        libfontconfig-dev \
        libfreetype-dev \
        libxinerama-dev \
        build-essential \
        clang \
        cmake \
        libx11-dev \
        libx11-xcb-dev \
        libxcb-res0-dev \
        libxft-dev

COPY build.sh /
