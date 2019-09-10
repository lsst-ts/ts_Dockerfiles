FROM lsstts/develop-env:salobj4_b38

WORKDIR /home/saluser/repos/ts_xml
RUN git fetch --all && git checkout tickets/DM-21161

WORKDIR /home/saluser/repos/ts_ATDome
RUN git fetch --all && git checkout tickets/DM-21161

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_salobj -t current && \
    setup ts_config_attcs -t current && \
    setup ts_ATDome -t current && \
    make_idl_files.py ATDome

WORKDIR /home/saluser

WORKDIR /home/saluser
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
