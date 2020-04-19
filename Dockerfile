FROM erdc/ubuntu_base:latest

MAINTAINER Proteus Project <proteus@googlegroups.com>

# Configure environment
ENV SHELL /bin/bash
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

USER root
WORKDIR /opt/proteus/

RUN git clone https://github.com/erdc/proteus && \
    cd proteus && \
    git checkout master && \
    git submodule update --init --recursive && \
    ./stack/hit/bin/hit init-home && \
    ./stack/hit/bin/hit remote add http://levant.hrwallingford.com/hashdist_src --objects="source" && \
    make stack stack/hit/bin/hit stack/default.yaml && \
    cd stack && \
    ./hit/bin/hit build -j 1 default.yaml -v && \
    chmod u+rwX -R /root/.hashdist/src && \
    rm -rf rm -rf /root/.hashdist/src && \
    rm -rf /root/.cache && \
    chmod u+rwX -R /root/.hashdist/bld/chrono/*/share/chrono/data && \
    rm -rf /root/.hashdist/bld/chrono/*/share/chrono/data/* && \
    rm -rf /opt/proteus/proteus/.git && \
    rm -rf /opt/proteus/stack/.git && \
    rm -rf /opt/proteus/air-water-vv/.git && \
    rm -rf /opt/proteus/proteus/air-water-vv && \
    rm -rf /opt/proteus/proteus/build && \
    rm -rf /opt/proteus/proteus/stack/default
