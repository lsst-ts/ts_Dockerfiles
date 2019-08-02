FROM tiagorib/ptkernel:rc0.5_sal3.10

USER root

RUN yum install -y qt5-qtbase-devel

USER saluser

RUN source /opt/lsst/software/stack/loadLSST.bash && \
    conda install -y -c anaconda pyqt

WORKDIR /home/saluser/repos/ts_pointing_common/src/python/gui/ui/

RUN source /opt/lsst/software/stack/loadLSST.bash && ./convert_ui.sh

WORKDIR /home/saluser/

COPY setup.sh /home/saluser/.setup.sh
