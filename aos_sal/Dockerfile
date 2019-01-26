# Dockerfile to execute a base machine with all set to test active optics
# system software wit the SAL environment

FROM lsstts/aos:w_2019_02

LABEL author="Te-Wei Tsai <ttsai@lsst.org>"

ARG LSST_USER=lsst
ARG LSST_USER_HOME=/home/$LSST_USER
ARG SAL_REPOS=$LSST_USER_HOME/sal_repos

USER root

# Install the required packages
RUN yum install -y gcc-c++ xterm xorg-x11-fonts-misc \
    java-1.7.0-openjdk-devel maven python-devel swig tk-devel \
    && yum clean all \
    && rm -rf /var/cache/yum

# Put the SAL environment path to the bashrc
RUN echo "" >> /root/.bashrc \
    && echo "# Setup the sal environment" >> /root/.bashrc \
    && echo "source $SAL_REPOS/ts_sal/setup.env" >> /root/.bashrc

# Set the firewall setting

# Download the needed SAL repo
USER $LSST_USER
WORKDIR $LSST_USER_HOME

RUN mkdir -p $SAL_REPOS \
    && cd $SAL_REPOS\
    && git clone -b master https://github.com/lsst-ts/ts_sal.git \
    && cd ts_sal/ \
    && git checkout c473240 \
    && cd .. \
    && git clone -b master https://github.com/lsst-ts/ts_xml.git \
    && cd ts_xml/ \
    && git checkout 601b64e \
    && cd .. \
    && git clone -b master https://github.com/lsst-ts/ts_opensplice.git \
    && cd ts_opensplice/ \
    && git checkout d0661fb9

# Set the needed environment variables of SAL
ENV LSST_SDK_INSTALL=$SAL_REPOS/ts_sal
ENV OSPL_HOME=$SAL_REPOS/ts_opensplice/OpenSpliceDDS/V6.4.1/HDE/x86_64.linux
ENV PYTHON_BUILD_VERSION=3.6m
ENV PYTHON_BUILD_LOCATION=/opt/lsst/python/miniconda3-4.5.4
ENV LSST_DDS_DOMAIN=activeOptics

# Put the SAL environment path to the bashrc
RUN echo "" >> $LSST_USER_HOME/.bashrc \
    && echo "# Setup the sal environment" >> $LSST_USER_HOME/.bashrc \
    && echo "source $SAL_REPOS/ts_sal/setup.env" >> $LSST_USER_HOME/.bashrc

# Set the default environment
SHELL ["/bin/bash", "-lc"]
WORKDIR $LSST_USER_HOME
