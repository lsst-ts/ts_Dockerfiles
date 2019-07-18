FROM lsstts/develop-env:latest

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER root

RUN yum install -y librdkafka-devel

USER saluser

WORKDIR /home/saluser/repos/ts_sal/test

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    cp ~/repos/ts_xml/sal_interfaces/*xml . && \
    cp ~/repos/ts_xml/sal_interfaces/ATCamera/*xml . && \
    salgenerator ATCamera validate && \
    salgenerator ATCamera sal html && \
    salgenerator ATCamera sal cpp && \
    salgenerator ATCamera lib && \
    echo "source ${LSST_SDK_INSTALL}/lsstsal/scripts/genkafkaefd.tcl ; updatekafkaschema" | tclsh

WORKDIR ${HOME}
