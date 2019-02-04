FROM centos:centos7

LABEL maintainer Rob Bovill (trekkie2@gmail.com)

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

USER root

# Create user and group
RUN groupadd -g 1001 lsst && \
adduser -u 1004 -m -g lsst -s /bin/bash ${USER}

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
gcc-c++ \
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
emacs \
make \
cmake && \
yum clean all

USER ${USER}
WORKDIR ${HOME}

RUN mkdir repos

ENV LSST_SDK_INSTALL=/home/saluser/repos/ts_sal
ENV OSPL_HOME=/home/saluser/repos/ts_opensplice/OpenSpliceDDS/V6.4.1/HDE/x86_64.linux
ENV PYTHON_BUILD_VERSION=3.6m
ENV PYTHON_BUILD_LOCATION=/opt/lsst/software/stack/python/miniconda3-4.3.21/
ENV LSST_DDS_DOMAIN=citest
ENV PTG_CONFIG_DIR=/home/saluser/repos/ts_pointing_common/install/data
ENV PTG_DATA_DIR=/home/saluser/repos/ts_pointing_common/install/data
ENV LSST_TOP=/home/saluser/repos/ts_pointing_common
ENV SLALIB_DIR=/home/saluser/repos/slalib_source_lsst_161203
ENV TCSPK_DIR=/home/saluser/repos/tcspk_source_lsst_161203
ENV LSST_TS_XML_DIR=/home/saluser/repos/ts_xml

#ENTRYPOINT ["/bin/bash", "--"]
#CMD ["/home/saluser/.setup.sh"]
