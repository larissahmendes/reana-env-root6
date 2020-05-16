# Environment: ROOT6 on Ubuntu/Bionic:
FROM ubuntu:bionic
RUN apt-get -y update && \
    apt-get -y install \
        binutils \
        build-essential \
        cmake \
        cpp \
        dpkg-dev \
        g++ \
        gcc \
        gfortran \
        git \
        graphviz-dev \
        libavahi-compat-libdnssd-dev \
        libffi-dev \
        libfftw3-dev \
        libftgl-dev \
        libglew1.5-dev \
        libgsl0-dev \
        libkrb5-dev \
        libldap2-dev \
        libmysqlclient-dev \
        libpcre3-dev \
        libpq-dev \
        libqt4-dev \
        libssl-dev \
        libx11-dev \
        libxext-dev \
        libxext-dev \
        libxft-dev \
        libxml2-dev \
        libxpm-dev \
        libxpm-dev \
        make \
        openssl \
        python-dev \
        python-pip \
        xlibmesa-glu-dev \
        zlib1g-dev && \
    apt-get -y autoremove && \
    apt-get -y clean

ENV ROOTSYS /usr/local
RUN git clone --quiet --depth 1 --branch v6-18-04 http://root.cern.ch/git/root.git /code/root && \
    cd /code && \
    mkdir _build && \
    cd _build && \
    cmake -Dcxx17=On -Dbuiltin_xrootd=On ../root && \
    cmake --build . -- -j3 && \
    cmake -P cmake_install.cmake && \
    cd / && \
    rm -rf /code

# Set helpful environment variables to point to local ROOT installation
ENV CMAKE_PREFIX_PATH=/usr/local
ENV DYLD_LIBRARY_PATH=/usr/local/lib
ENV JUPYTER_PATH=/usr/local/etc/notebook
ENV LD_LIBRARY_PATH=/usr/local/lib
ENV LIBPATH=/usr/local/lib
ENV PYTHONPATH=/usr/local/lib
ENV SHLIB_PATH=/usr/local/lib

#install python
RUN sudo apt-get install python

#install jupyter and dependencies
RUN sudo pip install jupyter metakernel zmq

