ARG deploy_tag=salobj_v5.7.0

FROM lsstts/deploy-env:${deploy_tag}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG atmcs=0.1.dev79+g96bd47a
ARG idl=1.1.3_4.8.0

RUN source /home/saluser/.setup.sh && \
    conda install -c lsstts ts-atmcs-simulator=${atmcs} ts-idl=${idl}

COPY setup.sh /home/saluser/.setup.sh
