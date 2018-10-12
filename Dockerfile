# Dockerfile to execute a base machine with all set to execute the Test example of a CSC of salObj

FROM centos:7

LABEL author="Andres Anania <aanania@lsst.org>"

# install required software
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
  python-devel \
  python-pip \
  python-wheel \
  which \
  gnome-terminal \
  nano && \
  yum clean all
RUN yum groupinstall -y "Development Tools" "Development Libraries" && \
  yum clean all

# install python3
COPY python3-to-install.tgz .
RUN tar -zxvf python3-to-install.tgz && rm python3-to-install.tgz
RUN cd Python-3.6.3 && make install

COPY ./requirements.txt /home/docker/requirements.txt
RUN pip3 install -r /home/docker/requirements.txt

RUN cd /home/docker/workspace
RUN git clone https://github.com/lsst-ts/ts_sal.git
RUN cd /home/docker/workspace/ts_sal 
RUN git checkout 58e32660e16121f115bf239e95cd8f1333bdeeea

RUN cd /home/docker/workspace
RUN git clone https://github.com/lsst-ts/ts_opensplice.git

ENV LSST_SDK_INSTALL=/home/docker/workspace/ts_sal
ENV OSPL_HOME=/home/docker/workspace/ts_opensplice/OpenSpliceDDS/V6.4.1/HDE/x86_64.linux
ENV PYTHON_BUILD_VERSION=3.6m
ENV PYTHON_BUILD_LOCATION=/usr/local
ENV LSST_DDS_DOMAIN=citest

# entrypoint
# ENTRYPOINT source /home/docker/workspace/ts_visit_simulator/setup.env && \
# xvfb-run sh /home/docker/workspace/run.sh
