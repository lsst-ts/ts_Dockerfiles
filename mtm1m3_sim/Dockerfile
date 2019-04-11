# Dockerfile to execute a base machine with an M1M3 simulator

FROM centos:7.6.1810

LABEL author="Christopher Contaxis <ccontaxis@lsst.org>"

ARG LSST_USER=lsst
ARG LSST_USER_HOME=/home/$LSST_USER
ARG REPOS=$LSST_USER_HOME/repos
ARG M1M3_SUPPORT_DIR=/usr/ts_M1M3Support

# Set the needed environment variables of SAL
ENV LSST_SDK_INSTALL=$REPOS/ts_sal
ENV OSPL_HOME=$REPOS/ts_opensplice/OpenSpliceDDS/V6.4.1/HDE/x86_64.linux
ENV PYTHON_BUILD_VERSION=3.6m
ENV PYTHON_BUILD_LOCATION=/usr/local
ENV LSST_DDS_DOMAIN=m1m3

USER root

# Install the required packages
RUN    yum update -y \
    && yum install -y git make gcc-c++ xterm xorg-x11-fonts-misc \
                      java-1.7.0-openjdk-devel maven python-devel \
                      swig tk-devel wget \
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
    && rm -rf Python-3.6.7

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
    && git clone -b develop https://github.com/lsst-ts/ts_m1m3support.git \
    && cd ts_m1m3support/ \
    && git checkout 27ce004 \
    && cd ..

# Build the SAL API for MTM1M3 and MTMount
WORKDIR $REPOS/ts_sal/test
RUN    source $REPOS/ts_sal/setup.env \
    && cp $REPOS/ts_xml/sal_interfaces/SAL*.xml . \
    && cp $REPOS/ts_xml/sal_interfaces/MTM1M3/*.xml . \
    && salgenerator MTM1M3 validate \
    && salgenerator MTM1M3 html \
    && salgenerator MTM1M3 sal cpp \
    && salgenerator MTM1M3 sal python \
    && salgenerator MTM1M3 lib \
    && cp $REPOS/ts_xml/sal_interfaces/MTMount/*.xml . \
    && salgenerator MTMount validate \
    && salgenerator MTMount html \
    && salgenerator MTMount sal cpp \
    && salgenerator MTMount sal python \
    && salgenerator MTMount lib

# Build the M1M3 Simulator
USER $LSST_USER
WORKDIR $REPOS/ts_m1m3support
RUN    tar xzf boost_1_65_1.tar.gz -C $REPOS \
    && cd Controller/CentOS/ \
    && make clean \
    && make 

# Copy M1M3 Simulator setting files and build product
USER root
WORKDIR $REPOS/ts_m1m3support/Controller/CentOS
RUN    mkdir -p $M1M3_SUPPORT_DIR \
    && cp -r $REPOS/ts_m1m3support/Controller/SettingFiles $M1M3_SUPPORT_DIR \
    && cp ts_M1M3Support /usr/local/bin

# Create the M1M3 Simulator startup script
USER $LSST_USER
WORKDIR $LSST_USER_HOME
RUN    echo "" >> $LSST_USER_HOME/startup.sh \
    && echo "source $REPOS/ts_sal/setup.env" >> $LSST_USER_HOME/startup.sh \
    && echo "ts_M1M3Support" >> $LSST_USER_HOME/startup.sh

# Setup the environment and run the startup script
SHELL ["/bin/bash", "-lc"]
CMD ["sh", "startup.sh"]
