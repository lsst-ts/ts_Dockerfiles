FROM lsstts/develop-env:sal_v4.0.0_salobj_v5.0.0

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER saluser

WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/ts_watcher.git

WORKDIR /home/saluser/repos/ts_watcher
RUN git fetch --all && git checkout "v0.2.1" -b "v0.2.1"

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    make_idl_files.py Watcher

WORKDIR /home/saluser/repos/ts_watcher
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . ts_watcher -t current && \
    setup ts_salobj -t current && \
    setup ts_watcher -t current && \
    scons

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    make_idl_files.py ATPtg \
                      ATHexapod \
                      ATMCS \
                      ATDomeTrajectory \
                      ATPneumatics \
                      ATAOS \
                      Environment \
                      DIMM \
                      GenericCamera \
                      ScriptQueue \
                      Script \
                      ATCamera \
                      ATSpectrograph \
                      ATArchiver \
                      ATHeaderService

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
