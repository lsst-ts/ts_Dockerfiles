FROM lsstts/develop-env:20190514

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

WORKDIR /home/saluser/repos/ts_sal/

RUN git fetch --all && git checkout "tickets/DM-20529"

WORKDIR /home/saluser/repos/ts_sal/test

COPY make_efd_writter.sh /home/saluser/repos/ts_sal/bin/

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    for COMP in Test Script ScriptQueue ATPtg ATMCS ATPneumatics ATHexapod ATAOS ATDome ATDomeTrajectory; do make_efd_writter.sh $COMP; done && \
    echo "source ${LSST_SDK_INSTALL}/lsstsal/scripts/gengenericefd_array.tcl ; updateefdschema" | tclsh

WORKDIR /home/saluser/
