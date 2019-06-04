# Dockerfile to execute a base machine with the MTAOS development environment

FROM lsstts/aos_aoclc:w_2019_20

LABEL author="Christopher Contaxis <ccontaxis@lsst.org>"

ARG LSST_USER=lsst
ARG LSST_USER_HOME=/home/$LSST_USER
ARG REPOS=$LSST_USER_HOME/repos

# Set the needed environment variables of SAL
ENV LSST_SDK_INSTALL=$REPOS/ts_sal
ENV OSPL_HOME=$REPOS/ts_opensplice/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux-debug
ENV PYTHON_BUILD_VERSION=3.7m
ENV PYTHON_BUILD_LOCATION=/opt/lsst/software/stack/python/miniconda3-4.5.12/envs/lsst-scipipe-1172c30
ENV LSST_DDS_DOMAIN=mtaos

USER root

# Install the required packages
RUN    yum update -y \
    && yum install -y git make gcc-c++ xterm xorg-x11-fonts-misc \
                      java-1.7.0-openjdk-devel maven python-devel \
                      swig tk-devel wget \
    && yum clean all \
    && rm -rf /var/cache/yum

# Install the needed python package
RUN conda install -y jsonschema

# Change to LSST user
USER $LSST_USER
WORKDIR $LSST_USER_HOME

# Download the required repos and checkout correct versions
RUN    mkdir -p $REPOS \
    && cd $REPOS\
    && git clone -b master https://github.com/lsst-ts/ts_sal.git \
    && cd ts_sal/ \
    && git checkout ac2ca6b \
    && cd .. \
    && git clone -b develop https://github.com/lsst-ts/ts_xml.git \
    && cd ts_xml/ \
    && git checkout 994918f \
    && cd .. \
    && git clone -b master https://github.com/lsst-ts/ts_opensplice.git \
    && cd ts_opensplice/ \
    && git checkout dba3466 \
    && cd .. \
    && git clone -b master https://github.com/lsst-ts/ts_salobj.git \
    && cd ts_salobj/ \
    && git checkout 4fea586 \
    && cd .. \
    && git clone -b develop https://github.com/lsst-ts/ts_config_ocs.git \
    && cd ts_config_ocs/ \
    && git checkout 0da9278 \
    && cd .. \
    && git clone -b develop https://github.com/lsst-ts/ts_config_mttcs.git \
    && cd ts_config_mttcs/ \
    && git checkout 0efe216

# Build the SAL API for Test
WORKDIR $REPOS/ts_sal/test
RUN    cd $REPOS/ts_sal/test \
    && source $REPOS/ts_sal/setup.env \
    && cp $REPOS/ts_xml/sal_interfaces/SAL*.xml . \
    && cp $REPOS/ts_xml/sal_interfaces/Test/*.xml . \
    && salgenerator Test validate \
    && salgenerator Test html \
    && salgenerator Test sal cpp \
    && salgenerator Test sal python \
    && salgenerator Test lib

# Build the SAL API for Hexapod
WORKDIR $REPOS/ts_sal/test
RUN    cd $REPOS/ts_sal/test \
    && source $REPOS/ts_sal/setup.env \
    && cp $REPOS/ts_xml/sal_interfaces/SAL*.xml . \
    && cp $REPOS/ts_xml/sal_interfaces/Hexapod/*.xml . \
    && salgenerator Hexapod validate \
    && salgenerator Hexapod html \
    && salgenerator Hexapod sal cpp \
    && salgenerator Hexapod sal python \
    && salgenerator Hexapod lib

# Build the SAL API for MTAOS
WORKDIR $REPOS/ts_sal/test
RUN    cd $REPOS/ts_sal/test \
    && source $REPOS/ts_sal/setup.env \
    && cp $REPOS/ts_xml/sal_interfaces/SAL*.xml . \
    && cp $REPOS/ts_xml/sal_interfaces/MTAOS/*.xml . \
    && salgenerator MTAOS validate \
    && salgenerator MTAOS html \
    && salgenerator MTAOS sal cpp \
    && salgenerator MTAOS sal python \
    && salgenerator MTAOS lib

# Build the SAL API for MTM1M3
WORKDIR $REPOS/ts_sal/test
RUN    cd $REPOS/ts_sal/test \
    && source $REPOS/ts_sal/setup.env \
    && cp $REPOS/ts_xml/sal_interfaces/SAL*.xml . \
    && cp $REPOS/ts_xml/sal_interfaces/MTM1M3/*.xml . \
    && salgenerator MTM1M3 validate \
    && salgenerator MTM1M3 html \
    && salgenerator MTM1M3 sal cpp \
    && salgenerator MTM1M3 sal python \
    && salgenerator MTM1M3 lib

# Build the SAL API for MTM2
WORKDIR $REPOS/ts_sal/test
RUN    cd $REPOS/ts_sal/test \
    && source $REPOS/ts_sal/setup.env \
    && cp $REPOS/ts_xml/sal_interfaces/SAL*.xml . \
    && cp $REPOS/ts_xml/sal_interfaces/MTM2/*.xml . \
    && salgenerator MTM2 validate \
    && salgenerator MTM2 html \
    && salgenerator MTM2 sal cpp \
    && salgenerator MTM2 sal python \
    && salgenerator MTM2 lib

# Install the required packages
RUN    source $REPOS/ts_sal/setup.env \
    && cd $REPOS/ts_xml \
    && setup -k -r . \
    && cd $REPOS/ts_sal \
    && setup -k -r . \
    && cd $REPOS/ts_config_ocs \
    && setup -k -r . \
    && cd $REPOS/ts_config_mttcs \
    && setup -k -r . \
    && cd $REPOS/ts_salobj \
    && setup -k -r . \
    && scons

# Add the ISR directory
WORKDIR $LSST_USER_HOME
RUN mkdir -p input

# Set the ISR directory environment variable
ENV ISRDIRPATH "$LSST_USER_HOME/input"

# Source the AOS environment and salobj environment
USER root
RUN echo "" >> /root/.bashrc \
    && echo "# Setup the MTAOS environment" >> /root/.bashrc \
    && echo "cd $REPOS/ts_xml" >> /root/.bashrc \
    && echo "setup -k -r ." >> /root/.bashrc \
    && echo "cd $REPOS/ts_sal" >> /root/.bashrc \
    && echo "setup -k -r ." >> /root/.bashrc \
    && echo "cd $REPOS/ts_config_ocs" >> /root/.bashrc \
    && echo "setup -k -r ." >> /root/.bashrc \
    && echo "cd $REPOS/ts_config_mttcs" >> /root/.bashrc \
    && echo "setup -k -r ." >> /root/.bashrc \
    && echo "cd $REPOS/ts_salobj" >> /root/.bashrc \
    && echo "setup -k -r ." >> /root/.bashrc \
    && echo "source $REPOS/ts_sal/setup.env" >> /root/.bashrc \
    && echo "cd $LSST_USER_HOME" >> /root/.bashrc

# Source the AOS environment and salobj environment
USER $LSST_USER
RUN echo "" >> /$LSST_USER_HOME/.bashrc \
    && echo "# Setup the MTAOS environment" >> /$LSST_USER_HOME/.bashrc \
    && echo "cd $REPOS/ts_xml" >> /$LSST_USER_HOME/.bashrc \
    && echo "setup -k -r ." >> /$LSST_USER_HOME/.bashrc \
    && echo "cd $REPOS/ts_sal" >> /$LSST_USER_HOME/.bashrc \
    && echo "setup -k -r ." >> /$LSST_USER_HOME/.bashrc \
    && echo "cd $REPOS/ts_config_ocs" >> /$LSST_USER_HOME/.bashrc \
    && echo "setup -k -r ." >> /$LSST_USER_HOME/.bashrc \
    && echo "cd $REPOS/ts_config_mttcs" >> /$LSST_USER_HOME/.bashrc \
    && echo "setup -k -r ." >> /$LSST_USER_HOME/.bashrc \
    && echo "cd $REPOS/ts_salobj" >> /$LSST_USER_HOME/.bashrc \
    && echo "setup -k -r ." >> /$LSST_USER_HOME/.bashrc \
    && echo "source $REPOS/ts_sal/setup.env" >> /$LSST_USER_HOME/.bashrc \
    && echo "cd $LSST_USER_HOME" >> /$LSST_USER_HOME/.bashrc

# Setup the environment and run the startup script
SHELL ["/bin/bash", "-lc"]
WORKDIR $LSST_USER_HOME
