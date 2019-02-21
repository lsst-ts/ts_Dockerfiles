FROM lsst/queue:latest

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER saluser

WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/ts_environment.git

WORKDIR /home/saluser

WORKDIR /home/saluser/repos/ts_xml
RUN git fetch && git checkout "origin/tickets/DM-17666" -b "tickets/DM-17666"

WORKDIR /home/saluser/repos/ts_salobj
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t $USER && \
    make_salpy_libs.py Environment

WORKDIR /home/saluser/repos/ts_environment
RUN git fetch && git checkout "tags/v0.1.1" -b "v0.1.1"

WORKDIR /home/saluser/repos/ts_environment
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_salobj -t $USER && \
    setup ts_sal -t $USER && \
    eups declare -r . ts_environment -t $USER && setup ts_environment -t $USER && \
    scons

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh
ENV STATION_INDEX=1

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
