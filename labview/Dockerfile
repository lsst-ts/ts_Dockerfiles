FROM lsst/queue:latest

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

RUN source /opt/lsst/software/stack/loadLSST.bash && conda install -y libgcc
COPY LabVIEW2016RTE_Linux.tar /tmp/labview/LabVIEW2016RTE_Linux.tar
USER root
WORKDIR /tmp/labview
RUN tar xvf LabVIEW2016RTE_Linux.tar && ./INSTALL
RUN rm /lib64/libstdc++.so.6 && ln -s /opt/lsst/software/stack/python/miniconda3-4.5.4/x86_64-conda_cos6-linux-gnu/sysroot/lib/libstdc++.so.6 /lib64/libstdc++.so.6
COPY cintools.tar /usr/local/natinst/LabVIEW-2016-64/cintools.tar
WORKDIR /usr/local/natinst/LabVIEW-2016-64/
RUN tar xvf cintools.tar

USER saluser
WORKDIR /home/saluser/

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
