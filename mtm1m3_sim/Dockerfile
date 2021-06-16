FROM lsstts/develop-env:develop as lsstts-cpp-dev

USER root
RUN yum -y install catch-devel boost169-devel make readline-devel yaml-cpp-devel

USER saluser

ARG M1M3_BRANCH=develop
ARG XML_BRANCH=$M1M3_BRANCH

WORKDIR /home/saluser/repos/ts_xml
RUN git checkout $XML_BRANCH && git pull

WORKDIR /home/saluser
RUN source .setup.sh \
    && cd repos/ts_sal \
    && cp ../ts_xml/sal_interfaces/*.xml ../ts_xml/sal_interfaces/MTM1M3TS/*.xml ../ts_xml/sal_interfaces/MTM1M3/*.xml ../ts_xml/sal_interfaces/MTMount/*.xml ../ts_xml/sal_interfaces/MTVMS/*.xml test \
    && cd test \
    && salgenerator generate cpp MTMount \
    && salgenerator generate cpp MTM1M3 \
    && salgenerator generate cpp MTM1M3TS \
    && salgenerator generate cpp MTVMS

USER root
RUN chmod a+rwX -R /home/saluser/
USER saluser

FROM lsstts-cpp-dev

ARG CRIOCPP_BRANCH=$M1M3_BRANCH
ARG M1M3SUPPORT_BRANCH=$M1M3_BRANCH
ARG M1M3THERMAL_BRANCH=$M1M3_BRANCH
ARG VMS_BRANCH=$M1M3_BRANCH

RUN cd repos && umask 0 && git clone --branch $CRIOCPP_BRANCH https://github.com/lsst-ts/ts_cRIOcpp
RUN cd repos && umask 0 && git clone --branch $M1M3SUPPORT_BRANCH https://github.com/lsst-ts/ts_m1m3support
RUN cd repos && umask 0 && git clone --branch $M1M3THERMAL_BRANCH https://github.com/lsst-ts/ts_m1m3thermal
RUN cd repos && umask 0 && git clone --branch $VMS_BRANCH https://github.com/lsst-ts/ts_vms

RUN source .setup.sh \
    && conda install -y readline yaml-cpp boost-cpp

RUN source .setup.sh \
    && cd repos/ts_cRIOcpp \
    && make

RUN source .setup.sh \
    && cd repos/ts_m1m3support \
    && make simulator

RUN source .setup.sh \
    && cd repos/ts_m1m3thermal \
    && LIBS_FLAGS=-L\${CONDA_PREFIX}/lib make simulator

RUN source .setup.sh \
    && cd repos/ts_vms \
    && CPPFLAGS=-I\${CONDA_PREFIX}/include LIBS_FLAGS=-L\${CONDA_PREFIX}/lib make simulator

COPY startup.sh .

SHELL ["/bin/bash", "-lc"]
ENTRYPOINT ["/home/saluser/startup.sh"]
