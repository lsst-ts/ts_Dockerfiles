FROM lsstts/develop-env:salobj4_b26

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER root

# RUN yum install -y librdkafka-devel

USER saluser

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib &&\
    conda install -y -c conda-forge kafkacat

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib &&\
    pip install "kafkit[aiohttp]"

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib &&\
    pip install aiokafka && \
    pip install confluent_kafka

WORKDIR /home/saluser/repos/ts_xml
RUN git fetch --all && git checkout "v3.10.0" -b "v3.10.0"

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    make_idl_files.py ATCamera

WORKDIR /home/saluser/repos/ts_salobj

RUN git fetch --all

RUN git checkout tickets/DM-20148

WORKDIR /home/saluser/repos/

RUN git clone https://github.com/lsst-ts/ts_salkafka.git

WORKDIR /home/saluser/repos/ts_salkafka

RUN git checkout tickets/DM-20911

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib &&\
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_salobj -t current && \
    eups declare -r . -t current && \
    setup ts_salkafka -t current && \
    scons

COPY setup.sh /home/saluser/.setup.sh

WORKDIR ${HOME}
