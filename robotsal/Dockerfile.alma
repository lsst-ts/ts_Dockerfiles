FROM lsstts/robot:alma
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

RUN python3.10 -m pip install awscli --upgrade

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

ADD maven.sh /etc/profile.d/
RUN wget -P /tmp https://mirrors.gigenet.com/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
RUN tar xf /tmp/apache-maven-3.6.3-bin.tar.gz -C /opt && \
ln -s /opt/apache-maven-3.6.3 /opt/maven && \
source /etc/profile.d/maven.sh && mvn --version

ADD OpenSpliceDDS-6.10.4-2.el8.x86_64.rpm ${HOME}
RUN yum -y install ${HOME}/OpenSpliceDDS-6.10.4-2.el8.x86_64.rpm

USER ${USER}

COPY --chown=1003:1003 start.sh ${HOME}/.
COPY --chown=1003:1003 rpmmacros ${HOME}/.rpmmacros
COPY --chown=0:0 rpmmacros /root/.rpmmacros

ENV LSST_SDK_INSTALL=$HOME/trunk/ts_sal
ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.10.4/HDE/x86_64.linux

RUN echo "" >> ${HOME}/.bash_profile && \
echo 'source /etc/profile.d/maven.sh' >> ${HOME}/.bash_profile && \
echo 'source $LSST_SDK_INSTALL/setup.env' >> ${HOME}/.bash_profile

ENV LSST_DDS_PARTITION_PREFIX=citest
