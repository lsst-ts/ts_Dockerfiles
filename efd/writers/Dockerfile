FROM lsstts/develop-env:develop

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

WORKDIR /home/saluser/repos/ts_sal/test

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    cp ~/repos/ts_xml/sal_interfaces/*xml . && \
    cp ~/repos/ts_xml/sal_interfaces/ATPtg/*xml . && \
    cp ~/repos/ts_xml/sal_interfaces/ATMCS/*xml . && \
    salgenerator ATPtg validate && \
    salgenerator ATPtg sal html && \
    salgenerator ATPtg sal cpp && \
    salgenerator ATPtg lib && \
    salgenerator ATMCS validate && \
    salgenerator ATMCS sal html && \
    salgenerator ATMCS sal cpp && \
    salgenerator ATMCS lib && \
    echo "source ${LSST_SDK_INSTALL}/lsstsal/scripts/gengenericefd_array.tcl ; updateefdschema" | tclsh

WORKDIR ${HOME}
