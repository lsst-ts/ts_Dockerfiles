FROM lsstts/develop-env:sal_v4.0.0_salobj_v5.0.0

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER saluser

WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/ts_FiberSpectrograph.git

WORKDIR /home/saluser

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    make_idl_files.py FiberSpectrograph

WORKDIR /home/saluser/repos/ts_FiberSpectrograph
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_salobj -t current && \
    setup ts_sal -t current && \
    eups declare -r . ts_FiberSpectrograph -t current && \
    setup ts_FiberSpectrograph -t current && \
    scons

WORKDIR /home/saluser/
COPY libavs.so.0.2.0 /usr/local/lib/
COPY 30-avantes-spec-usb.rules /etc/udev/rules.d/30-avantes-spec-usb.rules
# COPY setup.sh /home/saluser/.setup.sh
# ENV STATION_INDEX=1

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
