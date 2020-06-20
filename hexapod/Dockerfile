ARG deploy_tag=salobj_v5.7.0

FROM lsstts/deploy-env:${deploy_tag}

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ARG hexapod=0.1.dev65+ge3a234e
ARG hexrotcomm=0.5.0
ARG idl=1.1.3_4.8.0

RUN source /home/saluser/.setup.sh && \
    conda install -c lsstts ts-hexapod=${hexapod} ts-idl=${idl} ts-hexrotcomm=${hexrotcomm}

ENV RUN_ARG=""
COPY setup.sh /home/saluser/.setup.sh
