ARG deploy_tag=salobj_v5.7.0

FROM lsstts/deploy-env:${deploy_tag}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG athexapod=0.4.1
ARG idl=1.1.3_4.8.0
ARG config=v0.5.0

RUN git clone https://github.com/lsst-ts/ts_config_attcs.git

WORKDIR /home/saluser/ts_config_attcs

RUN git checkout ${config} -b ${config}

ENV TS_CONFIG_ATTCS_DIR=/home/saluser/ts_config_attcs
ENV RUN_ARG=""

WORKDIR /home/saluser/

RUN source /home/saluser/.setup.sh && \
    conda install -c lsstts ts-athexapod=${athexapod} ts-idl=${idl}

COPY setup.sh /home/saluser/.setup.sh
