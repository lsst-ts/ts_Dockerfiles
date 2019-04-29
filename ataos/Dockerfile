FROM lsstts/develop-env:develop

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER saluser

WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/ts_ataos.git

WORKDIR /home/saluser/repos/ts_ataos
RUN git fetch && git checkout v0.2

WORKDIR /home/saluser

WORKDIR /home/saluser/repos/ts_salobj
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t $USER && \
    make_salpy_libs.py ATAOS ATMCS ATPneumatics ATHexapod ATCamera ATPtg

WORKDIR /home/saluser/repos/ts_ataos
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_salobj -t $USER && \
    setup ts_sal -t $USER && \
    eups declare -r . ts_ataos -t $USER && setup ts_ataos -t $USER && \
    scons

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh
