ARG deploy_tag=salobj_v5.7.0

FROM lsstts/deploy-env:${deploy_tag}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG atspec=0.5.1
ARG idl=1.1.3_4.8.0
ARG config=v0.2.1

RUN git clone https://github.com/lsst-ts/ts_config_latiss.git

WORKDIR /home/saluser/ts_config_latiss

RUN git checkout ${config} -b ${config}

ENV TS_CONFIG_LATISS_DIR=/home/saluser/ts_config_latiss
ENV RUN_ARG=""

WORKDIR /home/saluser/

RUN source /home/saluser/.setup.sh && \
    conda install -c lsstts ts-atspec=${atspec} ts-idl=${idl}

COPY setup.sh /home/saluser/.setup.sh
