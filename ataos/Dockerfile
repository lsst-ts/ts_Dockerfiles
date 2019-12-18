FROM lsstts/develop-env:sal_v4.0.0_salobj_v5.0.0

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER saluser

WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/ts_ataos.git

WORKDIR /home/saluser/repos/ts_ataos
#RUN git fetch --all && git checkout "tags/v1.4.0" -b "v1.4.0"
RUN git fetch --all && git checkout "tickets/DM-22130"

#WORKDIR /home/saluser/repos/ts_config_attcs
##RUN git fetch --all && git checkout "v0.1-alpha.4" -b "v0.1-alpha.4"
##RUN git fetch --all && git checkout "v0.1.0" -b "v0.1.0"
##RUN git fetch && git checkout "tags/v0.1-alpha.1" -b "v0.1-alpha.1"
#RUN git fetch --all && git checkout "tickets/DM-21161"

WORKDIR /home/saluser

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    make_idl_files.py ATAOS ATMCS ATPneumatics ATHexapod ATCamera ATPtg

WORKDIR /home/saluser/repos/ts_ataos
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_salobj -t current && \
    setup ts_sal -t current && \
    eups declare -r . ts_ataos -t current && setup ts_ataos -t current && \
    scons

WORKDIR /home/saluser/repos/ts_config_attcs/
RUN git fetch --all && git checkout tickets/DM-22531

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
