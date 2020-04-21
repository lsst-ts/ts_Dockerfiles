FROM lsstts/deploy-env:salobj_v5.4.0_idl_v1.1.2_xml_v4.7.0

RUN git clone https://github.com/lsst-ts/ts_config_attcs.git

WORKDIR /home/saluser/ts_config_attcs

RUN git checkout "v0.4.0" -b "v0.4.0"

ENV TS_CONFIG_ATTCS_DIR=/home/saluser/ts_config_attcs

WORKDIR /home/saluser/

RUN source /home/saluser/.setup.sh && \
    conda install -c lsstts ts-ataos
