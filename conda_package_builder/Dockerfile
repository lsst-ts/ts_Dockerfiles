FROM centos:7

ARG PYTHON_VERSION=3.7m
ARG CONDA_VERSION=4.5.4

ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux

ENV PYTHON_BUILD_VERSION=${PYTHON_VERSION}
ENV PYTHON_BUILD_LOCATION=/home/saluser/miniconda3

USER root

RUN yum install -y mlocate
RUN adduser -u 1004 -m -s /bin/bash saluser
RUN yum install -y iproute gcc-c++ make ncurses-libs xterm xorg-x11-fonts-misc java-1.7.0-openjdk-devel maven python-devel swig git tk-devel wget bzip2

COPY lsst-ts-nexus.repo /etc/yum.repos.d

RUN yum install -y OpenSpliceDDS-6.9.0
USER saluser
WORKDIR /home/saluser

RUN wget --no-verbose https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh && chmod +x miniconda.sh && ./miniconda.sh -b

RUN source ~/miniconda3/bin/activate && \
    conda config --add channels conda-forge && \
    conda config --add channels lsstts && \
    conda install -y python=3.7 conda-build anaconda-client setuptools_scm black && \
    conda init bash

COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
