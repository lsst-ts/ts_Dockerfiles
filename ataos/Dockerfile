FROM lsst/queue:latest

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER saluser

WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/ts_ataos.git

WORKDIR /home/saluser

WORKDIR /home/saluser/repos/ts_salobj
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t $USER && \
    make_salpy_libs.py ATAOS ATPtg ATPneumatics ATHexapod ATCamera

#USER root
#RUN yum install -y "http://10.0.100.1/lsstrepo/ATAOS-3.9.0-1el7.centos.x86_64.rpm"

USER saluser


WORKDIR /home/saluser/repos/ts_ataos
RUN git fetch && git checkout "tags/v0.2" -b "v0.2"
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_salobj -t $USER && \
    eups declare -r . ts_ataos -t $USER && setup ts_ataos -t $USER && \
    scons

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
