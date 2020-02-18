# Dockerfile to execute a base machine with all set to test active optics
# system software with the needed AOS repositories

FROM lsstts/aos_sal:w_2020_06_sal

LABEL author="Te-Wei Tsai <ttsai@lsst.org>"

ARG LSST_USER=saluser
ARG LSST_USER_HOME=/home/${LSST_USER}
ARG AOS_REPOS=${LSST_USER_HOME}/repos
ARG PHOSIM_DIR=${LSST_USER_HOME}/phosim
ARG AOCLC_OUTPUT_PATH=${LSST_USER_HOME}/output
ARG LSST_DIR=/opt/lsst/software/stack
ARG SIMS_VERSION=current

# Change to LSST user
USER $LSST_USER
WORKDIR $LSST_USER_HOME

# Download the needed AOS repo
RUN cd ${AOS_REPOS} \
    && git clone -b master https://github.com/lsst-dm/phosim_utils.git \
    && cd phosim_utils/ \
    && git checkout 8744592 \
    && cd .. \
    && git clone -b feature/updateApi https://github.com/lsst-ts/ts_wep.git \
    && cd ts_wep/ \
    && git checkout 18c2303 \
    && cd .. \
    && git clone -b master https://github.com/lsst-ts/ts_ofc.git \
    && cd ts_ofc/ \
    && git checkout 558517c \
    && cd .. \
    && git clone -b master https://github.com/lsst-ts/ts_phosim.git \
    && cd ts_phosim/ \
    && git checkout bea66c0

# Add the PhoSim and output directory
RUN mkdir -p ${PHOSIM_DIR} \
    && mkdir -p ${AOCLC_OUTPUT_PATH}

# Set the PhoSim and output environment variables
ENV PHOSIMPATH "${PHOSIM_DIR}"
ENV AOCLCOUTPUTPATH "${AOCLC_OUTPUT_PATH}"

# Build the packages
WORKDIR $AOS_REPOS
RUN source ${LSST_DIR}/loadLSST.bash \
    && cd phosim_utils/ \
    && setup -k -r . -t ${SIMS_VERSION} \
    && scons \
    && cd ../ts_wep/ \
    && setup -k -r . \
    && scons \
    && cd ../ts_ofc/ \
    && setup -k -r . \
    && scons \
    && cd ../ts_phosim/ \
    && setup -k -r . \
    && scons

# Copy the file for the start of container with interactive environment
COPY setup.sh ${LSST_USER_HOME}/.setup.sh

# Set the default environment
SHELL ["/bin/bash", "-lc"]
WORKDIR $LSST_USER_HOME
