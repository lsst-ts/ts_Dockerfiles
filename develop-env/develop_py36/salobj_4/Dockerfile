ARG base_image_tag

FROM lsstts/salobj:$base_image_tag

WORKDIR /home/saluser/repos
RUN  git clone https://github.com/lsst-ts/ts_config_attcs.git && \
     git clone https://github.com/lsst-ts/ts_scriptqueue.git && \
     git clone https://github.com/lsst-ts/ts_standardscripts.git && \
     git clone https://github.com/lsst-ts/ts_externalscripts.git && \
     git clone https://github.com/lsst-ts/ts_ATMCSSimulator.git && \
     git clone https://github.com/lsst-ts/ts_ATDome.git && \
     git clone https://github.com/lsst-ts/ts_ATDomeTrajectory.git && \
     git clone https://github.com/lsst-ts/ts_simactuators.git

# Arguments for package versions
ARG config_attcs_v="tags/v0.1-alpha.4"
ARG atmcs_v="tags/v0.6.0"
ARG atdome_v="tags/v0.6.0"
ARG atdometraj_v="tags/v0.8.1"
ARG standardscripts_v="tags/v0.4.0"
ARG externalscripts_v="tags/v0.1.0"
ARG scriptqueue_v="tags/v2.1.0"
ARG simactuators_v="tags/v2.1.0"

WORKDIR /home/saluser/repos/ts_config_attcs
RUN /home/saluser/.checkout_repo.sh ${config_attcs_v}

WORKDIR /home/saluser/repos/ts_ATMCSSimulator
RUN /home/saluser/.checkout_repo.sh ${atmcs_v}

WORKDIR /home/saluser/repos/ts_standardscripts
RUN /home/saluser/.checkout_repo.sh ${standardscripts_v}

WORKDIR /home/saluser/repos/ts_externalscripts
RUN /home/saluser/.checkout_repo.sh ${externalscripts_v}

WORKDIR /home/saluser/repos/ts_ATDome
RUN /home/saluser/.checkout_repo.sh ${atdome_v}

WORKDIR /home/saluser/repos/ts_ATDomeTrajectory
RUN /home/saluser/.checkout_repo.sh ${atdometraj_v}

WORKDIR /home/saluser/repos/ts_scriptqueue
RUN /home/saluser/.checkout_repo.sh ${scriptqueue_v}

WORKDIR /home/saluser/repos/ts_simactuators
RUN /home/saluser/.checkout_repo.sh ${simactuators_v}

WORKDIR /home/saluser

WORKDIR /home/saluser/repos/ts_config_attcs
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    eups declare -r . ts_config_attcs -t current && \
    setup ts_config_attcs -t current

WORKDIR /home/saluser/
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    setup ts_idl -t current && \
    for comp in `ls $TS_XML_DIR/sal_interfaces/ | grep -v xml`; do echo "Builindg IDL for ${comp}"; make_idl_files.py $comp &> /dev/null || echo "FAILED to build idl for ${comp}" ;done

WORKDIR /home/saluser/repos/ts_simactuators
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    eups declare -r . ts_simactuators -t current && setup ts_simactuators -t current && \
    scons || pytest --color=no

WORKDIR /home/saluser/repos/ts_ATDome
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    setup ts_salobj -t current && \
    setup ts_config_attcs -t current && \
    eups declare -r . ts_ATDome -t current && setup ts_ATDome -t current && \
    scons || pytest --color=no

WORKDIR /home/saluser/repos/ts_ATDomeTrajectory
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    setup ts_salobj -t current && \
    setup ts_config_attcs -t current && \
    eups declare -r . ts_ATDomeTrajectory -t current && \
    setup ts_ATDomeTrajectory -t current && scons || pytest --color=no

WORKDIR /home/saluser/repos/ts_ATMCSSimulator
RUN  source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    setup ts_salobj -t current && \
    setup ts_config_attcs -t current && \
    eups declare -r . ts_ATMCSSimulator -t current && \
    setup ts_ATMCSSimulator -t current && \
    scons || pytest --color=no

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
    pytest --color=no || pytest --last-failed

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

#WORKDIR /home/saluser/
#COPY setup.sh /home/saluser/.setup.sh
#
#FROM step1

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
COPY setup.sh /home/saluser/.setup.sh
