FROM lsstts/develop-env:salobj4_b30

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER saluser

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
     make_idl_files.py ATCamera \
                       ATHeaderService \
                       ATArchiver \
                       ATMonochromator \
                       ATSpectrograph \
                       Electrometer \
                       Test \
                       ATPtg \
                       ATMCS \
                       ATDome \
                       ATDomeTrajectory \
                       ATPneumatics \
                       ATAOS \
                       MTM1M3

WORKDIR /home/saluser/repos/

RUN git clone https://github.com/lsst-ts/ts_salkafka.git

WORKDIR /home/saluser/repos/ts_salkafka

RUN git checkout tickets/DM-20911

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib &&\
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . -t current && \
    setup ts_salkafka -t current && \
    scons

COPY setup.sh /home/saluser/.setup.sh

WORKDIR ${HOME}
