FROM lsstts/deploy-env:salobj_v5.4.1_RC1_idl_1.1.1_v4.7.0

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER saluser

WORKDIR /home/saluser/

RUN git clone https://github.com/lsst-ts/ts_salkafka.git

WORKDIR /home/saluser/ts_salkafka

RUN git checkout tickets/DM-23354

#WORKDIR /home/saluser/repos/ts_xml
#RUN git fetch --all && git checkout "tags/v4.6.0" -b "v4.6.0"
#RUN git fetch --all && git checkout origin/tickets/DM-22700 -- sal_interfaces/ATAOS/ATAOS_Commands.xml
#RUN git fetch --all && git checkout origin/tickets/DM-22700 -- sal_interfaces/ATAOS/ATAOS_Events.xml

WORKDIR /home/saluser/ts_salkafka
#RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib &&\
#    source /home/saluser/repos/ts_sal/setup.env && \
#    eups declare -r . -t current && \
#    setup ts_salkafka -t current && \
#    scons

RUN source ~/miniconda3/bin/activate && \
    source $OSPL_HOME/release.com && \
    pip install .

COPY setup.sh /home/saluser/.setup.sh

WORKDIR /home/saluser
