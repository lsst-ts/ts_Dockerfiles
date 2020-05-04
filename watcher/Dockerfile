FROM lsstts/deploy-env:salobj_v5.4.0_idl_v1.1.2_xml_v4.7.0

RUN git clone https://github.com/lsst-ts/ts_config_ocs.git

ENV TS_CONFIG_OCS_DIR=/home/saluser/ts_config_ocs

WORKDIR /home/saluser/

RUN source /home/saluser/.setup.sh && \
    conda install -c lsstts ts-watcher="1.0.2rc1"


#FROM lsstts/develop-env:b32
#
#LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>
#
#USER saluser
#
#WORKDIR /home/saluser/repos
#RUN git clone https://github.com/lsst-ts/ts_watcher.git
#
#WORKDIR /home/saluser/repos/ts_watcher
#RUN git fetch --all && git checkout "v1.0.1" -b "v1.0.1"
#
#WORKDIR /home/saluser/repos/ts_watcher
#RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
#    source /home/saluser/repos/ts_sal/setup.env && \
#    eups declare -r . ts_watcher -t current && \
#    setup ts_salobj -t current && \
#    setup ts_watcher -t current && \
#    scons
#
#WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh
#
ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
