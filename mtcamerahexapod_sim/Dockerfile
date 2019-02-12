# Dockerfile to execute a base machine with a MT Camera Hexapod Simulator

FROM centos:7.6.1810

LABEL author="Christopher Contaxis <ccontaxis@lsst.org>"

ARG LSST_USER=lsst
ARG LSST_USER_HOME=/home/$LSST_USER
ARG REPOS=$LSST_USER_HOME/repos

# Set the needed environment variables of SAL
ENV LSST_SDK_INSTALL=$REPOS/ts_sal
ENV OSPL_HOME=$REPOS/ts_opensplice/OpenSpliceDDS/V6.4.1/HDE/x86_64.linux
ENV PYTHON_BUILD_VERSION=3.6m
ENV PYTHON_BUILD_LOCATION=/usr/local
ENV LSST_DDS_DOMAIN=mtcamerahexapod

USER root

# Install the required packages
RUN    yum update -y \
    && yum install -y git make gcc-c++ xterm xorg-x11-fonts-misc \
                      java-1.7.0-openjdk-devel maven python-devel \
                      swig tk-devel wget openssl-devel \
    && yum clean all \
    && rm -rf /var/cache/yum

# Install Python 3.6 from Source
RUN    wget https://www.python.org/ftp/python/3.6.7/Python-3.6.7.tgz \
    && tar -xzf Python-3.6.7.tgz \
    && cd Python-3.6.7 \
    && ./configure --enable-optimizations \
    && make install \
    && cd .. \
    && rm Python-3.6.7.tgz \
    && rm -rf Python-3.6.7 \
    && pip3.6 install numpy

# Add LSST user
RUN useradd -ms /bin/bash lsst

# Change to LSST user
USER $LSST_USER
WORKDIR $LSST_USER_HOME

# Download the required repos and checkout correct versions
RUN    mkdir -p $REPOS \
    && cd $REPOS\
    && git clone -b develop https://github.com/lsst-ts/ts_sal.git \
    && cd ts_sal/ \
    && git checkout 18cd34ecc0fd484550c8de78b06d0301863eaabd \
    && cd .. \
    && git clone -b develop https://github.com/lsst-ts/ts_xml.git \
    && cd ts_xml/ \
    && git checkout c51f11fa8a60d55879d1cebc970b7eedc37876eb \
    && cd .. \
    && git clone -b master https://github.com/lsst-ts/ts_opensplice.git \
    && cd ts_opensplice/ \
    && git checkout d0661fb \
    && cd .. \
    && git clone -b master https://github.com/lsst-ts/ts_salobj.git \
    && cd ts_salobj/ \
    && git checkout 078ad4cab91e7fb385e89dce89a9ea530dd0f503 \
    && cd ..

# Build the SAL API for Hexapod
WORKDIR $REPOS/ts_sal/test
RUN    source $REPOS/ts_sal/setup.env \
    && cp $REPOS/ts_xml/sal_interfaces/SAL*.xml . \
    && cp $REPOS/ts_xml/sal_interfaces/Hexapod/*.xml . \
    && salgenerator Hexapod validate \
    && salgenerator Hexapod html \
    && salgenerator Hexapod sal cpp \
    && salgenerator Hexapod sal python \
    && salgenerator Hexapod lib

# Load the Hexapod simulator scripts
USER $LSST_USER
WORKDIR $REPOS
COPY mtcamerahexapod_csc.py $REPOS

# Create the MTM2 Simulator startup script
WORKDIR $LSST_USER_HOME
RUN    echo "" >> $LSST_USER_HOME/startup.sh \
    && echo "source $REPOS/ts_sal/setup.env" >> $LSST_USER_HOME/startup.sh \
    && echo "export PYTHONPATH=$REPOS/ts_salobj/python:$REPOS/ts_sal/test/lib" >> $LSST_USER_HOME/startup.sh \
    && echo "python3.6 $REPOS/mtcamerahexapod_csc.py" >> $LSST_USER_HOME/startup.sh

# Setup the environment and run the startup script
SHELL ["/bin/bash", "-lc"]
CMD ["sh", "startup.sh"]
