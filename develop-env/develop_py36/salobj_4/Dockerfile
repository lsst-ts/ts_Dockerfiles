FROM step1

# Arguments for package versions
ARG scriptqueue_v="tags/v2.1.0"

WORKDIR /home/saluser/repos/ts_scriptqueue
RUN /home/saluser/.checkout_repo.sh ${scriptqueue_v}

WORKDIR /home/saluser

WORKDIR /home/saluser/repos/ts_scriptqueue
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    setup ts_idl -t current && \
    setup ts_salobj -t current && \
    eups declare -r . -t current && \
    setup ts_scriptqueue -t current && \
    scons

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh
