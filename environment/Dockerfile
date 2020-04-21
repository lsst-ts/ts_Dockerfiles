FROM lsstts/develop-env:sal_v4.0.0_salobj_v5.0.0

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER saluser

WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/ts_environment.git

WORKDIR /home/saluser/repos/ts_salobj
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    make_idl_files.py Environment

WORKDIR /home/saluser/repos/ts_environment
RUN git fetch && git checkout "tags/v1.0.0" -b "v1.0.0"

WORKDIR /home/saluser/repos/ts_environment
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_salobj -t current && \
    setup ts_sal -t current && \
    eups declare -r . ts_environment -t current && setup ts_environment -t current && \
    scons

WORKDIR /home/saluser/repos/ts_config_ocs
RUN git fetch --all && git checkout tickets/DM-22531

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh
ENV STATION_INDEX=1

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
