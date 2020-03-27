# Dockerfile to execute a base machine with the MTAOS simulation environment

FROM lsstts/aos_aoclc:w_2020_06_sal

LABEL author="Te-Wei Tsai <ttsai@lsst.org>"

ARG LSST_USER=saluser
ARG LSST_USER_HOME=/home/${LSST_USER}
ARG AOS_REPOS=${LSST_USER_HOME}/repos

# Change to LSST user
USER ${LSST_USER}
WORKDIR ${LSST_USER_HOME}

# Download the required repos and checkout correct versions
RUN cd ${AOS_REPOS} \
    && cd ts_xml/ \
    && git checkout 74ded62 sal_interfaces/MTM1M3/MTM1M3_Commands.xml \
    && git checkout f57e9d1 sal_interfaces/MTM1M3/MTM1M3_Events.xml \
    && cd .. \
    && git clone --branch develop https://github.com/lsst-ts/ts_config_mttcs \
    && cd ts_config_mttcs/ \
    && git checkout 2924779 \
    && cd .. \
    && git clone --branch develop https://github.com/lsst-ts/ts_MTAOS.git \
    && cd ts_MTAOS/ \
    && git checkout f9de1d7

# Install the required packages
COPY setupDocker.sh ${LSST_USER_HOME}
RUN source ${LSST_USER_HOME}/setupDocker.sh \
    && make_idl_files.py MTAOS Hexapod MTM1M3 MTM2 \
    && cd ${AOS_REPOS}/ts_config_mttcs/ \
    && setup -k -r .\
    && cd ${AOS_REPOS}/ts_MTAOS/ \
    && setup -k -r . \
    && scons

# Copy the file for the start of container with interactive environment
COPY setup.sh ${LSST_USER_HOME}/.setup.sh

# Set the default environment
SHELL ["/bin/bash", "-lc"]
WORKDIR $LSST_USER_HOME
