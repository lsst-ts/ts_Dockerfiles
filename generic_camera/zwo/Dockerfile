FROM lsstts/deploy-env:salobj_v5.0.0_xml_v4.4.1

RUN source ~/miniconda3/bin/activate && \
    conda install -y Pillow

RUN mkdir /home/saluser/repos

WORKDIR /home/saluser/repos

RUN git clone https://github.com/lsst-ts/ts_config_ocs.git
RUN git clone https://github.com/lsst-ts/ts_GenericCamera.git

WORKDIR /home/saluser/repos/ts_config_ocs

RUN git fetch --all && git checkout "tickets/DM-22531"

ENV TS_CONFIG_OCS_DIR=/home/saluser/repos/ts_config_ocs
ENV INDEX=1

WORKDIR /home/saluser/repos/ts_GenericCamera

RUN git fetch --all && git checkout tickets/DM-22531

COPY libASICamera2.so /home/saluser/repos/ts_GenericCamera/python/lsst/ts/GenericCamera/driver/
COPY libEFWFilter.so.0.3.1205 /home/saluser/repos/ts_GenericCamera/python/lsst/ts/GenericCamera/driver/libEFWFilter.so

RUN source ~/miniconda3/bin/activate && \
    source $OSPL_HOME/release.com && \
    pip install -e .

COPY setup.sh /home/saluser/.setup.sh

USER root

RUN yum install -y libusb1

RUN chmod a+rwx /home/saluser/.setup.sh

USER saluser

WORKDIR /home/saluser/
