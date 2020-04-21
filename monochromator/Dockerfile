FROM lsstts/develop-env:sal_v4.0.0_salobj_v5.0.0

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER saluser

WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/ts_atmonochromator.git

WORKDIR /home/saluser

WORKDIR /home/saluser/repos/ts_salobj
RUN git checkout "tags/v3.11.1" -b "v3.11.1"
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    make_salpy_libs.py ATMonochromator

WORKDIR /home/saluser/repos/ts_atmonochromator
RUN git fetch --tags && git checkout "tags/v0.1.1" -b "v0.1.1"
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_salobj -t current && \
    eups declare -r . ts_monochromator -t current && setup ts_monochromator -t current && \
    scons

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
