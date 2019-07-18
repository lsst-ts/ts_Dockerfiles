# Dockerfile to execute a base machine with the MTAOS simulation environment

FROM lsstts/mtaos_dev:v0.3

LABEL author="Te-Wei Tsai <ttsai@lsst.org>"

ARG LSST_USER=lsst
ARG LSST_USER_HOME=/home/$LSST_USER
ARG REPOS=$LSST_USER_HOME/repos

# Change to LSST user
USER $LSST_USER
WORKDIR $LSST_USER_HOME

# Download the required repos and checkout correct versions
RUN cd $REPOS \
    && git clone -b master https://github.com/lsst-ts/ts_MTAOS.git \
    && cd ts_MTAOS \
    && git checkout d018609

# Install the required packages
RUN cd $REPOS/ts_MTAOS \
    && setup -k -r . \
    && scons

# Source the AOS environment and salobj environment
USER root
RUN echo "" >> /root/.bashrc \
    && echo "# Setup the MTAOS environment" >> /root/.bashrc \
    && echo "cd $REPOS/ts_MTAOS" >> /root/.bashrc \
    && echo "setup -k -r ." >> /root/.bashrc \
    && echo "cd $LSST_USER_HOME" >> /root/.bashrc

# Source the AOS environment and salobj environment
USER $LSST_USER
RUN echo "" >> /$LSST_USER_HOME/.bashrc \
    && echo "# Setup the MTAOS environment" >> /$LSST_USER_HOME/.bashrc \
    && echo "cd $REPOS/ts_MTAOS" >> /$LSST_USER_HOME/.bashrc \
    && echo "setup -k -r ." >> /$LSST_USER_HOME/.bashrc \
    && echo "cd $LSST_USER_HOME" >> /$LSST_USER_HOME/.bashrc

# Setup the environment and run the startup script
SHELL ["/bin/bash", "-lc"]
WORKDIR $LSST_USER_HOME
