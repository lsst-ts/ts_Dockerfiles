FROM lsstts/deploy-env:salobj_v5.0.0_xml_v4.4.1

RUN source ~/miniconda3/bin/activate && \
    conda install -y Pillow

RUN mkdir /home/saluser/repos

WORKDIR /home/saluser/repos

RUN git clone https://github.com/lsst-ts/ts_config_ocs.git
RUN git clone https://github.com/lsst-ts/ts_GenericCamera.git

WORKDIR /home/saluser/repos/ts_config_ocs

RUN git fetch --all && git checkout "tags/v0.4.0" -b "v0.4.0"

ENV TS_CONFIG_OCS_DIR=/home/saluser/repos/ts_config_ocs
ENV INDEX=1

WORKDIR /home/saluser/repos/ts_GenericCamera

RUN git fetch --all && git checkout "tags/v0.2.0" -b "v0.2.0"

RUN source ~/miniconda3/bin/activate && \
    source $OSPL_HOME/release.com && \
    pip install -e .

COPY setup.sh /home/saluser/.setup.sh

USER root

RUN chmod a+rwx /home/saluser/.setup.sh

USER saluser

WORKDIR /home/saluser/
