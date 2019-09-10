FROM lsstts/develop-env:salobj4_b38

WORKDIR /home/saluser/repos

USER root
RUN mkdir /home/saluser/.ssh/ && chown saluser:lsst /home/saluser/.ssh/ && chmod 700 /home/saluser/.ssh/
COPY id_rsa /home/saluser/.ssh/
COPY known_hosts /home/saluser/.ssh/
RUN chown saluser:lsst /home/saluser/.ssh/id_rsa \
    && chown saluser:lsst /home/saluser/.ssh/known_hosts && \
    chmod 400 ~/.ssh/id_rsa

USER saluser

RUN git clone git@github.com:lsst-ts/tcspk_source_lsst_161203.git && \
 git clone git@github.com:lsst-ts/slalib_source_lsst_161203.git && \
 git clone git@github.com:lsst-ts/ts_pointing_common.git

WORKDIR /home/saluser

ENV PTG_CONFIG_DIR=/home/saluser/repos/ts_pointing_common/install/data
ENV PTG_DATA_DIR=/home/saluser/repos/ts_pointing_common/install/data
ENV LSST_TOP=/home/saluser/repos/ts_pointing_common
ENV SLALIB_DIR=/home/saluser/repos/slalib_source_lsst_161203
ENV TCSPK_DIR=/home/saluser/repos/tcspk_source_lsst_161203
ENV LSST_TS_XML_DIR=/home/saluser/repos/ts_xml

WORKDIR /home/saluser/repos/slalib_source_lsst_161203
RUN make

WORKDIR /home/saluser/repos/tcspk_source_lsst_161203
RUN make

WORKDIR /home/saluser/repos/ts_pointing_common
#RUN git fetch && git checkout "tickets/DM-19890"
RUN git fetch --all && git checkout "tags/v1.1rev0" -b "v1.1rev0"

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source $LSST_SDK_INSTALL/setup.env && setup ts_sal -t $USER && \
    ./scripts/generate_interface

RUN mkdir -p $PTG_DATA_DIR && cp $LSST_TOP/src/data/* $PTG_DATA_DIR/
#WORKDIR /home/saluser/repos/ts_xml
#RUN git checkout develop && git pull && \
#    cp -v sal_interfaces/ATMCS/ATMCS_*xml /home/saluser/repos/ts_sal/test
#WORKDIR /home/saluser/repos/ts_sal/test
#RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
#    source /home/saluser/repos/ts_sal/setup.env && \
#    setup ts_sal -t $USER && \
#    salgenerator ATMCS validate && \
#    salgenerator ATMCS html && \
#    salgenerator ATMCS sal cpp && \
#    salgenerator ATMCS sal python && \
#    salgenerator ATMCS lib

USER root
RUN yum install -y \
    boost-python \
    boost-python-devel \
    cmake \
    devtoolset-3
USER saluser

WORKDIR /home/saluser/repos/ts_pointing_common
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source scl_source enable devtoolset-3 && \
    source $LSST_SDK_INSTALL/setup.env && setup ts_sal -t current && \
    mkdir build && cd build && cmake -DAT=ON .. && make && cmake .. && make

WORKDIR /home/saluser/
COPY ATPtg.info /home/saluser/repos/ts_pointing_common/install/data/ATPtg.info
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
