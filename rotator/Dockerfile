FROM lsstts/develop-env:sal_v4.0.0_salobj_v5.0.0

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER saluser

WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/ts_rotator.git && \
    git clone https://github.com/lsst-ts/ts_hexrotcomm.git

WORKDIR /home/saluser/repos/ts_rotator
RUN git fetch --all && git checkout "tags/v0.1.0" -b "v0.1.0"

WORKDIR /home/saluser/repos/ts_hexrotcomm
RUN git fetch --all && git checkout "tags/v0.1.0" -b "v0.1.1"

WORKDIR /home/saluser
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    make_idl_files.py Rotator

WORKDIR /home/saluser/repos/ts_hexrotcomm
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_salobj -t current && \
    eups declare -r . -t current && setup ts_hexrotcomm -t current && \
    scons

WORKDIR /home/saluser/repos/ts_rotator
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_salobj -t current && \
    eups declare -r . -t current && setup ts_rotator -t current && \
    scons || echo "Failed, ignoring"

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
