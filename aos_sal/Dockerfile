# Dockerfile to execute a base machine with all set to test active optics
# system software with the SAL environment

FROM lsstts/aos:w_2019_02

LABEL author="Te-Wei Tsai <ttsai@lsst.org>"

ARG LSST_USER=lsst
ARG LSST_USER_HOME=/home/$LSST_USER
ARG SAL_REPOS=$LSST_USER_HOME/sal_repos

USER root

# Install the required packages
RUN yum install -y gcc-c++ xterm xorg-x11-fonts-misc \
    java-1.7.0-openjdk-devel maven python-devel swig tk-devel firewalld \
    && yum clean all \
    && rm -rf /var/cache/yum

# Put the SAL environment path to the bashrc
RUN echo "" >> /root/.bashrc \
    && echo "# Setup the sal environment" >> /root/.bashrc \
    && echo "source $SAL_REPOS/ts_sal/setup.env" >> /root/.bashrc

# Set the firewall setting

# Change to LSST user
USER $LSST_USER
WORKDIR $LSST_USER_HOME

# Download the needed SAL repo
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

# Build the SAL API of MTWEP, MTOFC, and MTM1M3
WORKDIR $SAL_REPOS/ts_sal/test
RUN source $SAL_REPOS/ts_sal/setup.env \
    && cp $SAL_REPOS/ts_xml/sal_interfaces/SAL*.xml . \
    && cp $SAL_REPOS/ts_xml/sal_interfaces/MTWEP/*.xml . \
    && salgenerator MTWEP validate \
    && salgenerator MTWEP html \
    && salgenerator MTWEP sal cpp \
    && salgenerator MTWEP sal python \
    && salgenerator MTWEP lib \
    && cp $SAL_REPOS/ts_xml/sal_interfaces/MTOFC/*.xml . \
    && salgenerator MTOFC validate \
    && salgenerator MTOFC html \
    && salgenerator MTOFC sal cpp \
    && salgenerator MTOFC sal python \
    && salgenerator MTOFC lib \
    && cp $SAL_REPOS/ts_xml/sal_interfaces/MTM1M3/*.xml . \
    && salgenerator MTM1M3 validate \
    && salgenerator MTM1M3 html \
    && salgenerator MTM1M3 sal cpp \
    && salgenerator MTM1M3 sal python \
    && salgenerator MTM1M3 lib

# Put the SAL environment path to the bashrc
RUN echo "" >> $LSST_USER_HOME/.bashrc \
    && echo "# Setup the sal environment" >> $LSST_USER_HOME/.bashrc \
    && echo "source $SAL_REPOS/ts_sal/setup.env" >> $LSST_USER_HOME/.bashrc

# Set the default environment
SHELL ["/bin/bash", "-lc"]
WORKDIR $LSST_USER_HOME
