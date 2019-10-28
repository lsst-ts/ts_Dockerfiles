ARG image_tag

FROM lsstts/salobj:${image_tag}

USER root

COPY P674-VortexOpenSplice-6.10.3-HDE-x86_64.linux-gcc4.8.2-glibc2.15-installer.run /opt/lsst

WORKDIR /opt/lsst

RUN chmod a+x P674-VortexOpenSplice-6.10.3-HDE-x86_64.linux-gcc4.8.2-glibc2.15-installer.run

RUN source /opt/lsst/software/stack/loadLSST.bash && \
    source /home/saluser/repos/ts_sal/setup.env && \
    ./P674-VortexOpenSplice-6.10.3-HDE-x86_64.linux-gcc4.8.2-glibc2.15-installer.run --mode unattended

WORKDIR /opt/ADLINK/Vortex_v2/Device/VortexOpenSplice/6.10.3/HDE/x86_64.linux/tools/python/src/

RUN source /opt/lsst/software/stack/loadLSST.bash && \
    source /home/saluser/repos/ts_sal/setup.env && \
    pip install --upgrade cython && \
    python setup.py install

USER saluser

ENV OSPL_HOME=/opt/ADLINK/Vortex_v2/Device/VortexOpenSplice/6.10.3/HDE/x86_64.linux

WORKDIR /home/saluser/
