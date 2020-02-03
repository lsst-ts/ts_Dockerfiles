FROM lsstts/develop-env:b22

MAINTAINER Tiago Ribeiro <tribeiro@lsst.org>

USER saluser

WORKDIR /home/saluser/repos
ENV TSREPOS=/home/saluser/repos

RUN git clone https://github.com/lsst-ts/ts_salobjATHexapod.git

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    make_idl_files.py ATHexapod

WORKDIR ${TSREPOS}/ts_config_attcs
RUN git fetch --all && git checkout tickets/DM-22546

WORKDIR ${TSREPOS}/ts_salobjATHexapod
RUN git checkout v0.3.0 -b v0.3.0
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_salobj -t current && \
    eups declare -r . ts_salobjATHexapod -t current && \
    setup ts_config_attcs -t current && \
    setup ts_salobjATHexapod  -t current && scons

WORKDIR /home/saluser/

COPY setup.sh /home/saluser/.setup.sh
