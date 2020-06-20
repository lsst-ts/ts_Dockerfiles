# Dockerfile to execute a base machine with the MTAOS simulation environment

ARG IMAGE_TAG
FROM lsstts/aos_aoclc:${IMAGE_TAG}

LABEL author="Te-Wei Tsai <ttsai@lsst.org>"

ARG LSST_USER=saluser
ARG LSST_USER_HOME=/home/${LSST_USER}
ARG AOS_REPOS=${LSST_USER_HOME}/repos

# Change to LSST user
USER ${LSST_USER}
WORKDIR ${LSST_USER_HOME}

# Download the required repos and checkout correct versions
RUN cd ${AOS_REPOS} \
    && git clone --branch master https://github.com/lsst-ts/ts_MTAOS.git \
    && cd ts_MTAOS/ \
    && git checkout 8b73ca2

# Copy the file for the start of container with interactive environment
COPY setup.sh ${LSST_USER_HOME}/setup.sh
COPY startup.sh ${LSST_USER_HOME}/startup.sh

# Set the default environment
SHELL ["/bin/bash", "-lc"]
WORKDIR $LSST_USER_HOME
CMD ["./startup.sh"]
