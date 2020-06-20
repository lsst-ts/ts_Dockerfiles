ARG deploy_tag=salobj_v5.7.0

FROM lsstts/deploy-env:${deploy_tag}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER root

RUN yum install -y iproute

USER saluser

ARG salkafka=v1.1.1
ARG idl=1.1.3_4.8.0

RUN source /home/saluser/.setup.sh && \
    pip install kafkit[aiohttp] aiokafka && \
    conda install -c lsstts ts-salkafka=${salkafka} ts-idl=${idl} python-confluent-kafka

COPY setup.sh /home/saluser/.setup.sh

WORKDIR /home/saluser
