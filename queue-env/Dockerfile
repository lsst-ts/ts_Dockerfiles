FROM lsstsqre/centos:7-stack-lsst_distrib-v16_0

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

USER root

# Create user and group
RUN adduser -m -g lsst -s /bin/bash saluser

RUN yum install -y https://centos7.iuscommunity.org/ius-release.rpm

RUN yum -y --enablerepo=extras install epel-release \
  unzip \
  wget \
  git \
  dos2unix \
  tk \
  tk-devel \
  swig \
  ncurses-libs \
  xterm \
  xorg-x11-fonts-misc \
  java-1.8.0-openjdk-devel \
  boost-python \
  boost-python-devel \
  maven \
  which \
  gnome-terminal \
  mariadb \
  mariadb-devel \
  nano \
  emacs && \
  yum clean all

USER saluser
WORKDIR /home/saluser

RUN source /opt/lsst/software/stack/loadLSST.bash

RUN mkdir repos

WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/ts_opensplice.git

WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/ts_sal.git
WORKDIR /home/saluser/repos/ts_sal
RUN git checkout "tags/v3.8.31" -b "v3.8.31"

WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/salobj.git
WORKDIR /home/saluser/repos/salobj
RUN git checkout "tags/2.3.0" -b "2.3.0"

WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/ts_scriptqueue.git
WORKDIR /home/saluser/repos/ts_scriptqueue

WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/ts_xml.git
WORKDIR /home/saluser/repos/ts_xml
# RUN git checkout "tags/v3.8.31" -b "v3.8.31"
RUN git checkout a2db54e64b1d19489cf5c05ff19fc4659293b933 -b "v3.8.31.1"
RUN cp sal_interfaces/SALGenerics.xml /home/saluser/repos/ts_sal/test/ && \
cp sal_interfaces/SALSubsystems.xml /home/saluser/repos/ts_sal/test/ && \
cp sal_interfaces/Test/*.xml /home/saluser/repos/ts_sal/test/ && \
cp sal_interfaces/Script/*.xml /home/saluser/repos/ts_sal/test/ && \
cp sal_interfaces/ScriptQueue/*.xml /home/saluser/repos/ts_sal/test/

WORKDIR /home/saluser

ENV LSST_SDK_INSTALL=/home/saluser/repos/ts_sal
ENV OSPL_HOME=/home/saluser/repos/ts_opensplice/OpenSpliceDDS/V6.4.1/HDE/x86_64.linux
ENV PYTHON_BUILD_VERSION=3.6m
ENV PYTHON_BUILD_LOCATION=/opt/lsst/software/stack/python/miniconda3-4.3.21/
ENV LSST_DDS_DOMAIN=citest

COPY setup.sh /home/saluser/setup.sh
COPY setup_and_build.sh /home/saluser/.setup_and_build.sh

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib &&\
    conda install -y ipython jupyter tornado=4.5.3 jinja2 scipy ephem gitpython && \
    conda update -y pyqt fontconfig sqlalchemy && \
    cd ../ && \
    python -c 'import matplotlib.pyplot' && \
    conda clean -ay

#RUN pip install ipython
#RUN pip install jupyter
RUN echo "echo source setup.sh to startupt" >> ~/.bashrc