ARG base_image_tag

FROM lsstts/salobj:$base_image_tag

COPY setup.sh /home/saluser/.setup_dev.sh

USER root
RUN chown saluser:lsst /home/saluser/.setup_dev.sh && \
    chmod a+x /home/saluser/.setup_dev.sh
USER saluser

ARG ts_scriptqueue="develop"
ARG ts_observatory_control="develop"
ARG ts_standardscripts="develop"
ARG ts_externalscripts="develop"
ARG ts_ATMCSSimulator="develop"
ARG ts_ATDome="develop"
ARG ts_ATDomeTrajectory="develop"
ARG ts_simactuators="develop"
ARG ts_hexrotcomm="develop"

RUN source /home/saluser/.setup_salobj.sh && \
    cd $EUPS_PATH/../tssw && \
    gitsrc="ts_scriptqueue:${ts_scriptqueue} \
            ts_observatory_control:${ts_observatory_control} \
            ts_standardscripts:${ts_standardscripts} \
            ts_externalscripts:${ts_externalscripts} \
            ts_ATMCSSimulator:${ts_ATMCSSimulator} \
            ts_ATDome:${ts_ATDome} \
            ts_ATDomeTrajectory:${ts_ATDomeTrajectory} \
            ts_simactuators:${ts_simactuators} \
            ts_hexrotcomm:${ts_hexrotcomm}" && \
    rb="https://github.com/lsst-ts" && \
    for g in $gitsrc ; do \
        r=$(echo ${g} | cut -d ':' -f 1) \
        t=$(echo ${g} | cut -d ':' -f 2) ;\
        git clone ${rb}/${r}.git ; \
        cd ${r} ; \
        /home/saluser/.checkout_repo.sh ${t} ; \
        eups declare -r . -t current ; \
        cd .. ; \
    done

WORKDIR /home/saluser/
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    setup ts_idl -t current && \
    make_idl_files.py --all

WORKDIR /home/saluser/repos/ts_simactuators
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    eups declare -r . ts_simactuators -t current && setup ts_simactuators -t current && \
    scons || pytest --color=no --last-failed

WORKDIR /home/saluser/repos/ts_ATDome
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    setup ts_salobj -t current && \
    setup ts_config_attcs -t current && \
    eups declare -r . ts_ATDome -t current && setup ts_ATDome -t current && \
    scons || pytest --color=no --last-failed

WORKDIR /home/saluser/repos/ts_ATDomeTrajectory
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    setup ts_salobj -t current && \
    setup ts_config_attcs -t current && \
    eups declare -r . ts_ATDomeTrajectory -t current && \
    setup ts_ATDomeTrajectory -t current && \
    scons || pytest --color=no --last-failed

WORKDIR /home/saluser/repos/ts_ATMCSSimulator
RUN  source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    setup ts_salobj -t current && \
    setup ts_config_attcs -t current && \
    eups declare -r . ts_ATMCSSimulator -t current && \
    setup ts_ATMCSSimulator -t current && \
    scons || pytest --color=no --last-failed

WORKDIR /home/saluser/repos/ts_observatory_control
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    eups declare -r . -t current && \
    setup ts_observatory_control -t current && \
    scons || pytest --color=no --last-failed

WORKDIR /home/saluser/repos/ts_standardscripts
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    setup ts_sal -t current && \
    setup ts_salobj -t current && \
    setup ts_config_attcs -t current && \
    setup ts_config_ocs -t current && \
    setup ts_ATMCSSimulator -t current && \
    eups declare -r . -t current && \
    setup ts_standardscripts -t current && \
    scons || pytest --color=no --last-failed

WORKDIR /home/saluser/repos/ts_externalscripts
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    setup ts_sal -t current && \
    setup ts_salobj -t current && \
    setup ts_standardscripts -t current && \
    setup ts_config_attcs -t current && \
    setup ts_config_ocs -t current && \
    eups declare -r . -t current && \
    setup ts_externalscripts -t current && \
    scons || echo Building external script failed. IGNORING...

WORKDIR /home/saluser

WORKDIR /home/saluser/repos/ts_scriptqueue
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    setup ts_sal -t current && \
    setup ts_idl -t current && \
    setup ts_salobj -t current && \
    eups declare -r . -t current && \
    setup ts_scriptqueue -t current && \
    pytest --color=no || pytest --last-failed

WORKDIR /home/saluser/

LABEL ts_scriptqueue="${ts_scriptqueue}" \
      ts_observatory_control="${ts_observatory_control}" \
      ts_standardscripts="${ts_standardscripts}" \
      ts_externalscripts="${ts_externalscripts}" \
      ts_ATMCSSimulator="${ts_ATMCSSimulator}" \
      ts_ATDome="${ts_ATDome}" \
      ts_ATDomeTrajectory="${ts_ATDomeTrajectory}" \
      ts_simactuators="${ts_simactuators}" \
      ts_hexrotcomm="${ts_hexrotcomm}"

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup_dev.sh"]
