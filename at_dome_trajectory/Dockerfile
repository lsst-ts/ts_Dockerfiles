ARG deploy_tag=salobj_v5.7.0

FROM lsstts/deploy-env:${deploy_tag}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG atdometrajectory=1.3.1
ARG idl=1.1.3_4.8.0
ARG config=v0.5.0

RUN source /home/saluser/.setup.sh && \
    conda install -c lsstts ts-atdometrajectory=${atdometrajectory} ts-idl=${idl}

RUN git clone https://github.com/lsst-ts/ts_config_attcs.git

WORKDIR /home/saluser/ts_config_attcs

RUN git checkout ${config} -b ${config}

WORKDIR /home/saluser/

ENV TS_CONFIG_ATTCS_DIR=/home/saluser/ts_config_attcs

COPY setup.sh /home/saluser/.setup.sh
