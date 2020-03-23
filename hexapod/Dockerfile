FROM lsstts/develop-env:b42

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
    && git checkout "v0.4.0" -b "v0.4.0"  \
    && cd ${SAL_REPOS} \
    && git clone https://github.com/lsst-ts/ts_hexrotcomm.git \
    && cd ts_hexrotcomm/ \
    && git checkout "v0.3.0" -b "v0.3.0"

WORKDIR ${SAL_REPOS}/ts_hexrotcomm

RUN source ${LSST_DIR}/loadLSST.bash \
    && setup lsst_distrib \
    && source ${SAL_REPOS}/ts_sal/setup.env \
    && eups declare -r . -t ${DISTRIB_VERSION} \
    && setup ts_salobj -t ${DISTRIB_VERSION} \
    && setup ts_hexrotcomm -t ${DISTRIB_VERSION} \
    && scons

WORKDIR ${SAL_REPOS}/ts_hexapod

RUN source ${LSST_DIR}/loadLSST.bash \
    && setup lsst_distrib \
    && source ${SAL_REPOS}/ts_sal/setup.env \
    && eups declare -r . -t ${DISTRIB_VERSION} \
    && setup ts_hexapod -t ${DISTRIB_VERSION} \
    && scons

ENV HEXAPOD_ID=1

COPY setup.sh ${LSST_USER_HOME}/.setup.sh

SHELL ["/bin/bash", "-lc"]
WORKDIR $LSST_USER_HOME

ENTRYPOINT ["/bin/bash", "--"]

CMD ["/home/saluser/.setup.sh"]
