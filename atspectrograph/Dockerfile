FROM lsst/queue:latest

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER saluser

WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/ts_atspec.git

WORKDIR /home/saluser/repos/ts_atspec
RUN git fetch && git checkout "tickets/DM-18358"

WORKDIR /home/saluser/repos/ts_xml
RUN git fetch && git checkout "tickets/DM-18358"

WORKDIR /home/saluser

WORKDIR /home/saluser/repos/ts_salobj
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t $USER && \
    make_salpy_libs.py ATSpectrograph ATCamera

WORKDIR /home/saluser/repos/ts_atspec
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_salobj -t $USER && \
    setup ts_sal -t $USER && \
    eups declare -r . ts_atspectrograph -t $USER && setup ts_atspectrograph -t $USER && \
    scons

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
