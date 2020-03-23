FROM lsstts/develop-env:b42

MAINTAINER Tiago Ribeiro <tribeiro@lsst.org>

USER saluser

WORKDIR /home/saluser/repos
ENV TSREPOS=/home/saluser/repos

RUN git clone https://github.com/lsst-ts/ts_salobjATHexapod.git

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
