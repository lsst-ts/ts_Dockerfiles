FROM lsstts/develop-env

MAINTAINER Andres Anania <aanania@lsst.org>

USER saluser

WORKDIR /home/saluser/repos
ENV TSREPOS=/home/saluser/repos

RUN git clone https://github.com/lsst-ts/pythonFileReader.git -b develop
RUN git clone https://github.com/lsst-ts/pythonCommunicator.git -b develop
RUN git clone https://github.com/lsst-ts/ts_salobjATHexapod.git -b develop

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    cd ${TSREPOS}/pythonFileReader && \
    pip install . && \
    cd ${TSREPOS}/pythonCommunicator && \
    pip install . && \
    setup ts_xml -t current && \
    setup ts_sal -t current && \
    cd ${TSREPOS}/ts_salobjATHexapod && \
    eups declare -r ${TSREPOS}/ts_salobjATHexapod ts_salobjATHexapod git -t current && \
    source ${TSREPOS}/ts_sal/setup.env && \
    make_salpy_libs.py ATHexapod

WORKDIR /home/saluser/

COPY setup.sh /home/saluser/.setup.sh
