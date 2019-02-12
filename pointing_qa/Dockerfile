FROM centos:centos7

LABEL maintainer Rob Bovill (trekkie2@gmail.com)

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

USER root

# Create user and group
RUN groupadd -g 1001 lsst && \
adduser -u 1004 -m -g lsst -s /bin/bash ${USER}

RUN yum -y --enablerepo=extras install epel-release && \
yum -y install python36 python36-devel python36-setuptools && \
yum -y install which unzip wget git \
tk tk-devel \
swig \
ncurses-libs \
boost-python boost-python-devel \
gcc-c++ \
xterm \
xorg-x11-fonts-misc \
java-1.8.0-openjdk-devel maven \
gnome-terminal \
mariadb mariadb-devel \
make cmake && \
yum clean all

RUN mkdir ${HOME}/.ssh && chown 1004:1001 ${HOME}/.ssh && chmod 700 ${HOME}/.ssh
COPY id_rsa ${HOME}/.ssh
COPY known_hosts ${HOME}/.ssh
RUN chown 1004:1001 ${HOME}/.ssh/id_rsa && chown 1004:1001 ${HOME}/.ssh/known_hosts

USER ${USER}
RUN mkdir ${HOME}/repos
WORKDIR ${HOME}

RUN git clone https://github.com/lsst-ts/ts_opensplice.git && \
git clone https://github.com/lsst-ts/ts_sal.git && \
git clone https://github.com/lsst-ts/ts_xml.git && \
git clone git@github.com:lsst-ts/tcspk_source_lsst_161203.git && \
git clone git@github.com:lsst-ts/slalib_source_lsst_161203.git

# SAL specific Environment Variables.
ENV LSST_SDK_INSTALL=/home/saluser/repos/ts_sal
ENV OSPL_HOME=/home/saluser/repos/ts_opensplice/OpenSpliceDDS/V6.4.1/HDE/x86_64.linux
ENV PYTHON_BUILD_VERSION=3.6m
ENV PYTHON_BUILD_LOCATION=/opt/lsst/software/stack/python/miniconda3-4.3.21/
ENV LSST_DDS_DOMAIN=pointing

# Pointing Component specific Environment Variables.
ENV SAL_WORK_DIR=${HOME}/repos/ts_sal/test
ENV PTG_CONFIG_DIR=/home/saluser/repos/ts_pointing_common/install/data
ENV PTG_DATA_DIR=/home/saluser/repos/ts_pointing_common/install/data
ENV LSST_TOP=/home/saluser/repos/ts_pointing_common
ENV SLALIB_DIR=/home/saluser/repos/slalib_source_lsst_161203
ENV TCSPK_DIR=/home/saluser/repos/tcspk_source_lsst_161203
ENV LSST_TS_XML_DIR=/home/saluser/repos/ts_xml

# Get the necessary SAL and XML versions.
WORKDIR ${LSST_SDK_INSTALL}
RUN git fetch && git checkout "tags/v3.8.41" -b "v3.8.41"

WORKDIR ${LSST_TS_XML_DIR}
RUN git fetch && git checkout -b "origin/develop"

# Build the SLALIB and TCSPK libraries.
WORKDIR ${SLALIB_DIR}
RUN make

WORKDIR ${TCSPK_DIR}
RUN make

WORKDIR ${HOME}

#ENTRYPOINT ["/bin/bash", "--"]
#CMD ["/home/saluser/.setup.sh"]
