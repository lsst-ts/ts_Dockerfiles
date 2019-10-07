# Dockerfile to execute a base machine to test the hexapod and rotator middleware code by Moog

FROM centos:7

LABEL author="Te-Wei Tsai <ttsai@lsst.org>"

ARG LSST_USER=lsst
ARG LSST_USER_HOME=/home/$LSST_USER
ARG SAL_XML_BUILD_VER=3.10.0-4.3.0.el7

# Set the needed environment variables of SAL
ENV SAL_HOME=/opt/lsst/ts_sal
ENV TOPIC_LIB=${SAL_HOME}/lib
ENV LD_LIBRARY_PATH=${TOPIC_LIB}:${LD_LIBRARY_PATH}
ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux
ENV LSST_DDS_DOMAIN=hexrot

USER root

# Install the required packages
RUN yum update -y \
    && yum install -y git make gcc-c++ xterm xorg-x11-fonts-misc \
    java-1.7.0-openjdk-devel maven python-devel swig tk-devel ncurses-libs \
    glib-devel glib2-devel.x86_64 libtool autoconf cmake \
    && yum clean all \
    && rm -rf /var/cache/yum

# Copy the lsst-ts.repo file
COPY lsst-ts.repo /etc/yum.repos.d/

# Install the needed CSC
RUN yum makecache fast \
    && yum install -y Hexapod-${SAL_XML_BUILD_VER} Rotator-${SAL_XML_BUILD_VER} \
    && yum clean all \
    && rm -rf /var/cache/yum

# Source the Open Splice DDS automatically
RUN echo "" >> /root/.bashrc \
    && echo "# Setup the Open Splice DDS environment" >> /root/.bashrc \
    && echo "source ${OSPL_HOME}/release.com" >> /root/.bashrc

# Add LSST user
RUN useradd -ms /bin/bash lsst

# Change to LSST user
USER ${LSST_USER}
WORKDIR ${LSST_USER_HOME}

# Source the Open Splice DDS automatically
RUN echo "" >> ${LSST_USER_HOME}/.bashrc \
    && echo "# Setup the Open Splice DDS environment" >> ${LSST_USER_HOME}/.bashrc \
    && echo "source ${OSPL_HOME}/release.com" >> ${LSST_USER_HOME}/.bashrc

# Set the default environment
SHELL ["/bin/bash", "-lc"]
WORKDIR ${LSST_USER_HOME}
