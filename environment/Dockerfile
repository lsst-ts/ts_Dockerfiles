FROM lsstts/develop-env:20190610_sal3.10.0_salobj3.12.0

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER saluser

WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/ts_environment.git

WORKDIR /home/saluser

WORKDIR /home/saluser/repos/ts_xml
RUN git fetch --all && git checkout "v4.2rev0" -b "v4.2rev0"

WORKDIR /home/saluser/repos/ts_salobj
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    make_salpy_libs.py Environment

WORKDIR /home/saluser/repos/ts_environment
RUN git fetch && git checkout "tags/v0.1.3" -b "v0.1.3"

WORKDIR /home/saluser/repos/ts_environment
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_salobj -t current && \
    setup ts_sal -t current && \
    eups declare -r . ts_environment -t current && setup ts_environment -t current && \
    scons

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh
ENV STATION_INDEX=1

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
