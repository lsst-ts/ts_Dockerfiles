FROM lsstts/develop-env:20190418

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER saluser

WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/ts_ataos.git

WORKDIR /home/saluser/repos/ts_ataos
RUN git fetch && git checkout "tags/v0.2.2" -b "v0.2.2"
WORKDIR /home/saluser

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    make_salpy_libs.py ATAOS ATMCS ATPneumatics ATHexapod ATCamera ATPtg

WORKDIR /home/saluser/repos/ts_ataos
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_salobj -t current && \
    setup ts_sal -t current && \
    eups declare -r . ts_ataos -t current && setup ts_ataos -t current && \
    scons

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
