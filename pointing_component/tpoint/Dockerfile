FROM ts-dockerhub.lsst.org/ptkernel:v1.1.0_rc4_b42

USER root

RUN yum install -y rlwrap

USER saluser

RUN mkdir tpoint/

WORKDIR /home/saluser/repos/

RUN git clone git@github.com:lsst-ts/tpoint_exec_161103.git

WORKDIR /home/saluser/repos/tpoint_exec_161103/tpoint/

ENV PATH=${PATH}:/home/saluser/tpoint/bin/

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source scl_source enable devtoolset-3 && \
    source $LSST_SDK_INSTALL/setup.env && setup ts_sal -t current && \
    make INSTALL_DIR=/home/saluser/tpoint/

WORKDIR /home/saluser/

COPY setup.sh /home/saluser/.setup.sh
