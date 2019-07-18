FROM lsstts/develop-env:develop

#WORKDIR /home/saluser/repos/ts_scriptqueue
#RUN git fetch && git checkout "tags/v1.4.1" -b "v1.4.1"

##RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
#    source /home/saluser/repos/ts_sal/setup.env && \
#    setup ts_sal -t current && \
#    setup ts_salobj -t current && \
#    setup ts_scriptqueue -t current && \
#    scons

USER root

RUN yum install -y tzdata

WORKDIR /usr/share/zoneinfo

RUN wget http://www.ietf.org/timezones/data/leap-seconds.list

USER saluser

WORKDIR /home/saluser/
