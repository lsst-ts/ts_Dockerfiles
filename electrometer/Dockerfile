FROM lsstts/develop-env:b45
ARG electrometer_version
WORKDIR /home/saluser/repos
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    pip install pyserial && \
    git clone https://github.com/lsst-ts/ts_electrometer2 && \
    cd ts_electrometer2 && git checkout ${electrometer_version}
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_idl -t current && setup ts_salobj -t current && \
    make_idl_files.py Electrometer && cd ts_electrometer2 && setup -kr . && scons install declare
