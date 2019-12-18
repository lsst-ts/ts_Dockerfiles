FROM lsstts/deploy-env:salobj_v5.0.0_xml_v4.4.1

RUN mkdir /home/saluser/telemetry
RUN mkdir /home/saluser/repos

WORKDIR /home/saluser/repos

RUN git clone https://github.com/lsst-ts/ts_config_eas.git
RUN git clone https://github.com/lsst-ts/ts_dsm.git

ENV TS_CONFIG_EAS_DIR=/home/saluser/repos/ts_config_eas
ENV CSC_INDEX=1
ENV CSC_MODE=0

WORKDIR /home/saluser/repos/ts_dsm

RUN git fetch --all && git checkout tickets/DM-22706

RUN source ~/miniconda3/bin/activate && \
    source $OSPL_HOME/release.com && \
    pip install -e .

COPY setup.sh /home/saluser/.setup.sh

USER saluser

WORKDIR /home/saluser/
