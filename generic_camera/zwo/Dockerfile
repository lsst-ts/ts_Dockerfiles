FROM lsstts/develop-env:20190705_sal3.10.0_salobj

RUN source /opt/lsst/software/stack/loadLSST.bash && \
    conda install -y Pillow

WORKDIR /home/saluser/repos/ts_config_ocs

RUN git fetch --all && git checkout "tags/v0.0-alpha.1" -b "v0.0-alpha.1"

WORKDIR /home/saluser/repos/

RUN git clone https://github.com/lsst-ts/ts_GenericCamera.git

COPY libASICamera2.so /home/saluser/repos/ts_GenericCamera/python/lsst/ts/GenericCamera/driver/

WORKDIR /home/saluser/repos/ts_GenericCamera

RUN git fetch --all && git checkout tickets/DM-20737

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    make_idl_files.py GenericCamera

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_salobj -t current && \
    setup ts_sal -t current && \
    eups declare -r . -t current && setup ts_GenericCamera -t current && \
    scons

WORKDIR /home/saluser/