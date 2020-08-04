FROM lsstts/robot:latest
MAINTAINER Rob Bovill (trekkie2@gmail.com)
ARG USER=appuser
ARG HOME=/home/${USER}

USER root
WORKDIR /

RUN mkdir /root/.aws
ADD aws_config /root/.aws/config
ADD lv_includes.tgz /
ADD mavenrepo69.tgz /root
ADD mavenrepo69.tgz ${HOME}
ADD settings.xml ${HOME}/.m2
RUN chown -R 1003:1003 ${HOME}/.m2 

RUN python3.7 -m pip install awscli --upgrade

RUN yum -y install tk tk-devel \
swig ncurses-libs xterm \
xorg-x11-fonts-misc \
maven java-1.8.0-openjdk-devel \
gnome-terminal \
mariadb mariadb-devel \
make gcc-c++ \
rpm-build && \
yum clean all && \
rm -rf /var/cache/yum

RUN curl -s https://repo-nexus.lsst.org/nexus/repository/ts_yum/master/OpenSpliceDDS-6.9.0-6.x86_64.rpm --output OpenSpliceDDS-6.9.0-6.x86_64.rpm
RUN yum -y install OpenSpliceDDS-6.9.0-6.x86_64.rpm

USER ${USER}

COPY --chown=1003:1003 start.sh ${HOME}/.
COPY --chown=1003:1003 rpmmacros ${HOME}/.rpmmacros
COPY --chown=0:0 rpmmacros /root/.rpmmacros

ENV LSST_SDK_INSTALL=$HOME/trunk/ts_sal
ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux
ENV PYTHON_BUILD_VERSION=3.7m
ENV PYTHON_BUILD_LOCATION=/usr/local
ENV LSST_DDS_DOMAIN=citest

RUN echo "" >> ${HOME}/.bash_profile && \
echo 'source $LSST_SDK_INSTALL/setup.env' >> ${HOME}/.bash_profile
