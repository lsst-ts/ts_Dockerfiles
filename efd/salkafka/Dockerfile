FROM lsstts/deploy-env:salobj_v5.4.0_idl_v1.1.2_xml_v4.7.0

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

RUN source /home/saluser/.setup.sh && \
    pip install kafkit[aiohttp] aiokafka && \
    conda install -c lsstts ts-salkafka

COPY setup.sh /home/saluser/.setup.sh

WORKDIR /home/saluser
