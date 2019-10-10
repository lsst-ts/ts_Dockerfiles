FROM lsstts/develop-env:salobj4_b38

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER saluser

WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/ts_dimm.git && git clone https://github.com/lsst-ts/ts_config_ocs

WORKDIR /home/saluser/repos/ts_dimm
RUN git fetch && git checkout "tickets/DM-21423"

WORKDIR /home/saluser/repos/ts_config_ocs
RUN git fetch && git checkout tickets/DM-21423

WORKDIR /home/saluser

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    make_salpy_libs.py Environment && \
    make_idl_files.py DIMM

WORKDIR /home/saluser/repos/ts_dimm
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_salobj -t current && \
    setup ts_sal -t current && \
    eups declare -r . ts_dimm -t current && setup ts_dimm -t current && \
    scons

ENV CSC_INDEX=1

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
