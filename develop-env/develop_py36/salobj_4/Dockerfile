ARG base_image_tag

FROM lsstts/salobj:$base_image_tag

WORKDIR /home/saluser/repos
RUN  git clone https://github.com/lsst-ts/ts_config_attcs.git && \
     git clone https://github.com/lsst-ts/ts_scriptqueue.git && \
     git clone https://github.com/lsst-ts/ts_standardscripts.git && \
     git clone https://github.com/lsst-ts/ts_externalscripts.git && \
     git clone https://github.com/lsst-ts/ts_ATMCSSimulator.git && \
     git clone https://github.com/lsst-ts/ts_ATDome.git && \
     git clone https://github.com/lsst-ts/ts_ATDomeTrajectory.git

# Arguments for package versions
ARG scriptqueue_v="tags/v2.1.0"
ARG config_attcs_v="tags/v0.1-alpha.4"
ARG atmcs_v="tags/v0.6.0"
ARG atdome_v="tags/v0.6.0"
ARG atdometraj_v="tags/v0.8.1"
ARG standardscripts_v="tags/v0.4.0"
ARG externalscripts_v="tags/v0.1.0"

WORKDIR /home/saluser/repos/ts_scriptqueue
RUN git_v=${scriptqueue_v} && \
    git fetch --all && \
    if [[ ${git_v} == tags/* ]] ; \
    then \
        echo checkout ${git_v} -b $git_v ; \
        git checkout ${git_v} -b $git_v ; \
    else \
        echo checkout ${git_v} ; \
        git checkout ${git_v} ; \
    fi

WORKDIR /home/saluser/repos/ts_config_attcs
RUN git_v=${config_attcs_v} && \
    git fetch --all && \
    if [[ ${git_v} == tags/* ]] ; \
    then \
        echo checkout ${git_v} -b $git_v ; \
        git checkout ${git_v} -b $git_v ; \
    else \
        echo checkout ${git_v} ; \
        git checkout ${git_v} ; \
    fi

WORKDIR /home/saluser/repos/ts_ATMCSSimulator
RUN git_v=${atmcs_v} && \
    git fetch --all && \
    if [[ ${git_v} == tags/* ]] ; \
    then \
        echo checkout ${git_v} -b $git_v ; \
        git checkout ${git_v} -b $git_v ; \
    else \
        echo checkout ${git_v} ; \
        git checkout ${git_v} ; \
    fi

WORKDIR /home/saluser/repos/ts_standardscripts
RUN git_v=${standardscripts_v} && \
    git fetch --all && \
    if [[ ${git_v} == tags/* ]] ; \
    then \
        echo checkout ${git_v} -b $git_v ; \
        git checkout ${git_v} -b $git_v ; \
    else \
        echo checkout ${git_v} ; \
        git checkout ${git_v} ; \
    fi

WORKDIR /home/saluser/repos/ts_externalscripts
RUN git_v=${externalscripts_v} && \
    git fetch --all && \
    if [[ ${git_v} == tags/* ]] ; \
    then \
        echo checkout ${git_v} -b $git_v ; \
        git checkout ${git_v} -b $git_v ; \
    else \
        echo checkout ${git_v} ; \
        git checkout ${git_v} ; \
    fi

WORKDIR /home/saluser/repos/ts_ATDome
RUN git_v=${atdome_v} && \
    git fetch --all && \
    if [[ ${git_v} == tags/* ]] ; \
    then \
        echo checkout ${git_v} -b $git_v ; \
        git checkout ${git_v} -b $git_v ; \
    else \
        echo checkout ${git_v} ; \
        git checkout ${git_v} ; \
    fi

WORKDIR /home/saluser/repos/ts_ATDomeTrajectory
RUN git_v=${atdometraj_v} && \
    git fetch --all && \
    if [[ ${git_v} == tags/* ]] ; \
    then \
        echo checkout ${git_v} -b $git_v ; \
        git checkout ${git_v} -b $git_v ; \
    else \
        echo checkout ${git_v} ; \
        git checkout ${git_v} ; \
    fi

WORKDIR /home/saluser

WORKDIR /home/saluser/repos/ts_config_attcs
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . ts_config_attcs -t current && setup ts_config_attcs -t current

WORKDIR /home/saluser/
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    setup ts_idl -t current && \
    make_idl_files.py ScriptQueue Script Test ATDome ATMCS ATDomeTrajectory \
    Electrometer ATPtg ATCamera ATMonochromator ATSpectrograph \
    FiberSpectrograph

WORKDIR /home/saluser/repos/ts_ATDome
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_salobj -t current && \
    setup ts_config_attcs -t current && \
    eups declare -r . ts_ATDome -t current && setup ts_ATDome -t current && scons

WORKDIR /home/saluser/repos/ts_ATDomeTrajectory
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_salobj -t current && \
    setup ts_config_attcs -t current && \
    eups declare -r . ts_ATDomeTrajectory -t current && setup ts_ATDomeTrajectory -t current && scons

WORKDIR /home/saluser/repos/ts_ATMCSSimulator
RUN  source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_salobj -t current && \
    setup ts_config_attcs -t current && \
    eups declare -r . ts_ATMCSSimulator -t current && \
    setup ts_ATMCSSimulator -t current && \
    scons

WORKDIR /home/saluser/repos/ts_standardscripts
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    setup ts_salobj -t current && \
    setup ts_config_attcs -t current && \
    setup ts_config_ocs -t current && \
    setup ts_ATMCSSimulator -t current && \
    eups declare -r . -t current && \
    setup ts_standardscripts -t current && \
    scons || echo Building external script failed. IGNORING...

WORKDIR /home/saluser/repos/ts_externalscripts
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    setup ts_salobj -t current && \
    setup ts_standardscripts -t current && \
    setup ts_config_attcs -t current && \
    setup ts_config_ocs -t current && \
    eups declare -r . -t current && \
    setup ts_externalscripts -t current && \
    scons || echo Building external script failed. IGNORING...

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
