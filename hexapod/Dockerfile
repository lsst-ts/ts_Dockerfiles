FROM lsstts/develop-env:salobj4_develop

LABEL author="Te-Wei Tsai <ttsai@lsst.org>"

ARG LSST_USER=saluser
ARG LSST_USER_HOME=/home/${LSST_USER}
ARG SAL_REPOS=${LSST_USER_HOME}/repos
ARG LSST_DIR=/opt/lsst/software/stack
ARG DISTRIB_VERSION=current

USER $LSST_USER
WORKDIR $LSST_USER_HOME

RUN cd ${SAL_REPOS} \
    && git clone https://github.com/lsst-ts/ts_hexapod.git \
    && cd ts_hexapod/ \
    && git checkout -t origin/tickets/DM-22385 \
    && cd ${SAL_REPOS} \
    && git clone https://github.com/lsst-ts/ts_hexrotcomm.git \
    && cd ts_hexrotcomm/ \
    && git checkout -t origin/develop

RUN source ${LSST_DIR}/loadLSST.bash \
    && setup lsst_distrib \
    && source ${SAL_REPOS}/ts_sal/setup.env \
    && setup ts_sal -t ${DISTRIB_VERSION} \
    && setup ts_salobj -t ${DISTRIB_VERSION} \
    && setup ts_idl -t ${DISTRIB_VERSION} \
    && make_idl_files.py Rotator Hexapod \
    && cd ${SAL_REPOS}/ts_hexrotcomm/ \
    && eups declare -r . -t ${DISTRIB_VERSION} \
    && setup ts_hexrotcomm -t ${DISTRIB_VERSION} \
    && scons \
    && cd ${SAL_REPOS}/ts_hexapod \
    && eups declare -r . -t ${DISTRIB_VERSION} \
    && setup ts_hexapod -t ${DISTRIB_VERSION} \
    && scons

COPY setup.sh ${LSST_USER_HOME}/.setup.sh

SHELL ["/bin/bash", "-lc"]
WORKDIR $LSST_USER_HOME

ENTRYPOINT ["/bin/bash", "--"]
# CMD ["/home/saluser/.setup.sh"]
