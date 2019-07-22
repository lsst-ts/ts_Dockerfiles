FROM centos:7
ARG PYTHON_VERSION=3.6m
ARG CONDA_VERSION=4.5.4
USER root
RUN yum install -y mlocate
RUN adduser -u 1004 -m -s /bin/bash saluser
RUN yum install -y gcc-c++ make ncurses-libs xterm xorg-x11-fonts-misc java-1.7.0-openjdk-devel maven python-devel swig git tk-devel wget bzip2
COPY lsst-ts.repo /tmp/lsst-ts.repo
RUN cat /tmp/lsst-ts.repo >> /etc/yum.conf && yum install -y OpenSpliceDDS-6.9.0-1
USER saluser
WORKDIR /home/saluser
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh && chmod +x miniconda.sh && ./miniconda.sh -b
RUN source ~/miniconda3/bin/activate && conda install python=3.6
RUN mkdir repos && cd repos && git clone https://github.com/lsst-ts/ts_sal \ 
    && cd ts_sal && git checkout v3.10.0 && cd .. && git clone https://github.com/lsst-ts/ts_xml && cd ts_xml \ 
    && git checkout v3.10.2 && cd .. && git clone https://github.com/lsst-ts/ts_idl
ENV LSST_SDK_INSTALL=/home/saluser/repos/ts_sal
ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux
ENV LSST_DDS_DOMAIN=citest
ENV PYTHON_BUILD_VERSION=${PYTHON_VERSION}
ENV PYTHON_BUILD_LOCATION=/home/saluser/miniconda3