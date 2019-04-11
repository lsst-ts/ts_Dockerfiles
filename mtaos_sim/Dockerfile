# Dockerfile to execute a base machine with the MTAOS simulation environment

FROM lsstts/mtaos_dev:v0.1

LABEL author="Christopher Contaxis <ccontaxis@lsst.org>"

ARG LSST_USER=lsst
ARG LSST_USER_HOME=/home/$LSST_USER
ARG REPOS=$LSST_USER_HOME/repos

# Set the needed environment variables of SAL
ENV LSST_SDK_INSTALL=$REPOS/ts_sal
ENV OSPL_HOME=$REPOS/ts_opensplice/OpenSpliceDDS/V6.4.1/HDE/x86_64.linux
ENV PYTHON_BUILD_VERSION=3.6m
ENV PYTHON_BUILD_LOCATION=/opt/lsst/python/miniconda3-4.5.4
ENV LSST_DDS_DOMAIN=mtaos

# Change to LSST user
USER $LSST_USER
WORKDIR $LSST_USER_HOME

# Download the required repos and checkout correct versions
RUN    cd $REPOS/ \
    && git clone -b develop https://github.com/lsst-ts/ts_MTAOS.git \
    && cd ts_MTAOS/ \
    && git checkout db912d312a271a19cb479a32104c3091dd02d7e6 \
    && cd ..

# Install the required packages
RUN    cd $REPOS/ts_MTAOS \
    && setup -k -r . -t sims_w_2019_02 \
    && scons

# Source the AOS environment and salobj environment
USER root
RUN echo "" >> /root/.bashrc \
    && echo "# Setup the aos environment" >> /root/.bashrc \
    && echo "cd $REPOS/ts_MTAOS" >> /root/.bashrc \
    && echo "setup -k -r . -t sims_w_2019_02" >> /root/.bashrc \
    && echo "cd $LSST_USER_HOME" >> /root/.bashrc

# Source the AOS environment and salobj environment
USER $LSST_USER
RUN echo "" >> /$LSST_USER_HOME/.bashrc \
    && echo "# Setup the aos environment" >> /$LSST_USER_HOME/.bashrc \
    && echo "cd $REPOS/ts_MTAOS" >> /$LSST_USER_HOME/.bashrc \
    && echo "setup -k -r . -t sims_w_2019_02" >> /$LSST_USER_HOME/.bashrc \
    && echo "cd $LSST_USER_HOME" >> /$LSST_USER_HOME/.bashrc

# Setup the environment and run the startup script
SHELL ["/bin/bash", "-lc"]
WORKDIR $LSST_USER_HOME