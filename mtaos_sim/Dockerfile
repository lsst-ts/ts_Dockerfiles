# Dockerfile to execute a base machine with the MTAOS simulation environment

FROM lsstts/mtaos_dev:v0.2

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

# Change to LSST user
USER $LSST_USER
WORKDIR $LSST_USER_HOME

# Download the required repos and checkout correct versions
RUN    cd $REPOS/ \
    && git clone -b develop https://github.com/lsst-ts/ts_MTAOS.git \
    && cd ts_MTAOS/ \
    && git checkout 82b9e60b1e076e5b26bca8b6a98c88152305dfa2 \
    && cd ..

# Install the required packages
RUN    cd $REPOS/ts_MTAOS \
    && setup -k -r . -t sims_w_2019_18 \
    && scons

# Install required files
COPY testData $LSST_USER_HOME/testData/
COPY mtaos_test.py $LSST_USER_HOME
COPY zkAndDofIdxArraySet.yaml $LSST_USER_HOME/aos_repos/ts_ofc/policy

# Source the AOS environment and salobj environment
USER root
RUN echo "" >> /root/.bashrc \
    && echo "# Setup the aos environment" >> /root/.bashrc \
    && echo "cd $REPOS/ts_MTAOS" >> /root/.bashrc \
    && echo "setup -k -r . -t sims_w_2019_18" >> /root/.bashrc \
    && echo "cd $LSST_USER_HOME" >> /root/.bashrc

# Source the AOS environment and salobj environment
USER $LSST_USER
RUN echo "" >> /$LSST_USER_HOME/.bashrc \
    && echo "# Setup the aos environment" >> /$LSST_USER_HOME/.bashrc \
    && echo "cd $REPOS/ts_MTAOS" >> /$LSST_USER_HOME/.bashrc \
    && echo "setup -k -r . -t sims_w_2019_18" >> /$LSST_USER_HOME/.bashrc \
    && echo "cd $LSST_USER_HOME" >> /$LSST_USER_HOME/.bashrc

# Setup the environment and run the startup script
SHELL ["/bin/bash", "-lc"]
WORKDIR $LSST_USER_HOME