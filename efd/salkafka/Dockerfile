FROM lsstts/deploy-env:salobj_v5.7.0

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG salkafka=v1.1.1
ARG idl=1.1.3_4.8.0

RUN source /home/saluser/.setup.sh && \
    pip install kafkit[aiohttp] aiokafka && \
    conda install -c lsstts ts-salkafka=${salkafka} ts-idl=${idl}

COPY setup.sh /home/saluser/.setup.sh

WORKDIR /home/saluser
