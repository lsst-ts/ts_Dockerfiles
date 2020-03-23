FROM lsstts/develop-env:b42

WORKDIR /home/saluser/repos

RUN git clone https://github.com/lsst-ts/ts_ATPneumaticsSimulator.git

WORKDIR /home/saluser/repos/ts_ATPneumaticsSimulator

RUN git checkout "v0.4.0" -b "v0.4.0"

RUN source /opt/lsst/software/stack/loadLSST.bash && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_idl -t current && \
    make_idl_files.py ATPneumatics

RUN source /opt/lsst/software/stack/loadLSST.bash && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . ts_ATPneumaticsSimulator -t current && \
    setup ts_ATPneumaticsSimulator -t current && \
    scons

WORKDIR /home/saluser
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
