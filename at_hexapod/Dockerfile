FROM lsst/queue:latest

MAINTAINER Andres Anania <aanania@lsst.org>

USER saluser

WORKDIR /home/saluser/repos
ENV TSREPOS=/home/saluser/repos

RUN git clone https://github.com/lsst-ts/ts_salobjATHexapod.git -b develop
RUN git clone https://github.com/lsst-ts/pythonFileReader.git -b develop
RUN git clone https://github.com/lsst-ts/pythonCommunicator.git -b develop

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    cd /home/saluser/repos/pythonFileReader && \
    pip install . && \
    cd /home/saluser/repos/pythonCommunicator && \
    pip install . && \
    eups declare -r ${TSREPOS}/ts_xml ts_xml git -t current && \
    setup ts_xml && \
    eups declare -r ${TSREPOS}/ts_sal ts_sal git -t current && \
    setup ts_sal && \
    eups declare -r ${TSREPOS}/ts_salobj ts_salobj git -t current && \
    setup ts_salobj && \
    eups declare -r ${TSREPOS}/ts_salobjATHexapod ts_salobjATHexapod git -t current && \
    setup ts_salobjATHexapod && \
    source ${TSREPOS}/ts_sal/setup.env && \
    make_salpy_libs.py ATHexapod

WORKDIR /home/saluser/
