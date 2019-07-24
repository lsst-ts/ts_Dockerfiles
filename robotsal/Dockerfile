FROM lsstts/robot:python37
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

RUN curl -s https://project.lsst.org/ts/lsstrepo/OpenSpliceDDS-6.9.0-4.x86_64.rpm --output OpenSpliceDDS-6.9.0-4.x86_64.rpm
RUN yum -y install OpenSpliceDDS-6.9.0-4.x86_64.rpm

USER ${USER}

ADD --chown=1001 start.sh ${HOME}/.

ENV LSST_SDK_INSTALL=$HOME/trunk/ts_sal
ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux
ENV PYTHON_BUILD_VERSION=3.7m
ENV PYTHON_BUILD_LOCATION=/usr/local
ENV LSST_DDS_DOMAIN=citest

RUN echo "" >> ${HOME}/.bash_profile && \
echo 'source $LSST_SDK_INSTALL/setup.env' >> ${HOME}/.bash_profile
