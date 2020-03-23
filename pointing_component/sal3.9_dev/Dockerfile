FROM lsstts/develop-env:b42

WORKDIR /home/saluser/repos

USER root
RUN mkdir /home/saluser/.ssh/ && chown saluser:lsst /home/saluser/.ssh/ && chmod 700 /home/saluser/.ssh/
COPY id_rsa /home/saluser/.ssh/
COPY known_hosts /home/saluser/.ssh/
RUN chown saluser:lsst /home/saluser/.ssh/id_rsa \
    && chown saluser:lsst /home/saluser/.ssh/known_hosts && \
    chmod 400 ~/.ssh/id_rsa

RUN yum install -y \
    boost-python \
    boost-python-devel \
    cmake \
    devtoolset-3

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
RUN git fetch && git checkout "tickets/DM-22702"
#RUN git fetch --all && git checkout "tags/v1.1.0_rc3" -b "v1.1.0_rc3"

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source $LSST_SDK_INSTALL/setup.env && setup ts_sal -t $USER && \
    ./scripts/generate_interface && \
    rm /home/saluser/repos/ts_sal/test/Environment/cpp/src/sacpp_*_send

RUN mkdir -p $PTG_DATA_DIR && cp $LSST_TOP/src/data/* $PTG_DATA_DIR/
RUN mkdir /home/saluser/repos/ts_pointing_common/build/

WORKDIR /home/saluser/

WORKDIR /home/saluser/repos/ts_pointing_common/build/
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source $LSST_SDK_INSTALL/setup.env && setup ts_sal -t current && \
    cmake .. && make

WORKDIR /home/saluser/repos/ts_pointing_common/build/
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source $LSST_SDK_INSTALL/setup.env && setup ts_sal -t current && \
    cmake -DAT=ON .. && make

ENV TELESCOPE=Main

WORKDIR /home/saluser/
COPY ATPtg.info /home/saluser/repos/ts_pointing_common/install/data/ATPtg.info
COPY MTPtg.info /home/saluser/repos/ts_pointing_common/install/data/MTPtg.info
COPY auxtel_20191211_fauto.mod /home/saluser/repos/ts_pointing_common/install/data/auxtel_20191211_fauto.mod
COPY at_20200219_fauto.mod /home/saluser/repos/ts_pointing_common/install/data/at_20200219_fauto.mod
COPY at_20200219_manual.mod /home/saluser/repos/ts_pointing_common/install/data/at.mod
COPY setup.sh /home/saluser/.setup.sh
USER root
RUN chown saluser:lsst -R /home/saluser/repos/ts_pointing_common/install/data/ && \
    chown saluser:lsst /home/saluser/.setup.sh && \
    chmod a+x /home/saluser/.setup.sh
USER saluser

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
