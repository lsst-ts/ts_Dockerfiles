FROM lsstts/develop-env:salobj4_b65

MAINTAINER Andres Anania <aanania@lsst.org>

USER saluser

WORKDIR /home/saluser/repos
ENV TSREPOS=/home/saluser/repos

RUN source /opt/lsst/software/stack/loadLSST.bash && \
    conda install -y -c conda pyqt && \
    conda install -y -c conda pyqtgraph

RUN git clone https://github.com/lsst-ts/pythonFileReader.git -b develop
RUN git clone https://github.com/lsst-ts/pythonCommunicator.git -b develop
RUN git clone https://github.com/lsst-ts/ts_salobjATHexapod.git

#WORKDIR ${TSREPOS}/ts_xml
#RUN git fetch --all && git checkout "v4.2rev0" -b "v4.2rev0"

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    make_salpy_libs.py ATHexapod

WORKDIR ${TSREPOS}/pythonFileReader
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    pip install .

WORKDIR ${TSREPOS}/pythonCommunicator
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    pip install .

WORKDIR ${TSREPOS}/ts_salobjATHexapod
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_salobj -t current && \
    eups declare -r . ts_salobjATHexapod -t current && \
    setup ts_salobjATHexapod  -t current

WORKDIR /home/saluser/repos/ts_salobjATHexapod/bin/

COPY setup.sh /home/saluser/.setup.sh
