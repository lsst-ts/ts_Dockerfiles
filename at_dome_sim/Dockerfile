FROM lsstts/develop-env:20190610_sal3.10.0_salobj4

WORKDIR /home/saluser/repos/ts_config_attcs
RUN git fetch --tags && git checkout "tags/v0.1-alpha.0" -b "v0.1-alpha.0"

WORKDIR /home/saluser/repos/ts_ATDome
RUN git fetch --tags && git checkout "tags/v0.6.1" -b "v0.6.1"
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_ATDome -t current && scons

WORKDIR /home/saluser
COPY setup.sh /home/saluser/.setup.sh
