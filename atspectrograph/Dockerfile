FROM lsstts/develop-env:salobj4_b65

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER saluser

WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/ts_atspec.git && \
    git clone https://github.com/lsst-ts/ts_config_latiss.git

WORKDIR /home/saluser/repos/ts_atspec
# RUN git fetch --tags && git checkout "tags/v0.3.0" -b "v0.3.0"
RUN git fetch --tags && git checkout tickets/DM-22016

WORKDIR /home/saluser/repos/ts_config_latiss
RUN git fetch --tags && git checkout "tags/v0.1.0" -b "v0.1.0"

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . -t current

WORKDIR /home/saluser

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    make_idl_files.py ATSpectrograph ATCamera

WORKDIR /home/saluser/repos/ts_atspec
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_salobj -t current && \
    setup ts_sal -t current && \
    eups declare -r . ts_atspectrograph -t current && \
    setup ts_atspectrograph -t current && \
    scons

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
