FROM lsstts/develop-env:salobj4_b38

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER saluser

WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/ts_environment.git

WORKDIR /home/saluser/repos/ts_config_ocs
RUN git fetch --all && git checkout "tags/v0.2.1" -b "v0.2.1"

WORKDIR /home/saluser/repos/ts_xml
RUN git fetch --all && git checkout "v4.2rev0" -b "v4.2rev0"

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    make_idl_files.py Environment

WORKDIR /home/saluser/repos/ts_environment
RUN git fetch --all && git checkout "tags/v1.0.0" -b "v1.0.0"

WORKDIR /home/saluser/repos/ts_environment
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . ts_environment -t current && \
    setup ts_environment -t current && \
    scons

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh

ENV STATION_INDEX=1

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
