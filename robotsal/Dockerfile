FROM lsstts/robot:latest
MAINTAINER Rob Bovill (trekkie2@gmail.com)
ARG USER=appuser
ARG HOME=/home/${USER}

USER root

RUN yum -y install tk tk-devel \
swig ncurses-libs xterm \
xorg-x11-fonts-misc \
maven java-1.8.0-openjdk-devel \
gnome-terminal \
mariadb mariadb-devel \
make gcc-c++ && \
yum clean all && \
rm -rf /var/cache/yum

USER ${USER}

ADD --chown=1001 start.sh ${HOME}/.

ENV LSST_SDK_INSTALL=$HOME/trunk/ts_sal
ENV OSPL_HOME=$HOME/trunk/ts_opensplice/OpenSpliceDDS/V6.4.1/HDE/x86_64.linux
ENV PYTHON_BUILD_VERSION=3.6m
ENV PYTHON_BUILD_LOCATION=/usr
ENV LSST_DDS_DOMAIN=citest

RUN echo "" >> ${HOME}/.bash_profile && \
echo 'source $LSST_SDK_INSTALL/setup.env' >> ${HOME}/.bash_profile
