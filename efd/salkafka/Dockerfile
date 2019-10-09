FROM lsstts/develop-env:salobj4_b38

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER saluser

WORKDIR /home/saluser/repos/ts_xml
RUN git checkout tags/v3.10.2 -b tags/v3.10.2

WORKDIR /home/saluser/repos/

RUN git clone https://github.com/lsst-ts/ts_salkafka.git

WORKDIR /home/saluser/repos/ts_salkafka

RUN git checkout "tags/v1.0b1" -b "v1.0b1"

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib &&\
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . -t current && \
    setup ts_salkafka -t current && \
    scons

COPY setup.sh /home/saluser/.setup.sh

WORKDIR ${HOME}
