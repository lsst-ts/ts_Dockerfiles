FROM lsstts/develop-env:sal_v4.0.0_salobj_v5.0.0

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

USER saluser

RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups distrib install palpy 1.8.1+6 && \
    eups distrib install sims_data 2018.05.08 && \
    eups distrib install sims_survey_fields 2.6.0.sims+32

WORKDIR /home/saluser
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    make_idl_files.py Scheduler ScriptQueue Script

WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/ts_scheduler.git && \
    git clone https://github.com/lsst/sims_seeingModel.git && \
    git clone https://github.com/lsst/sims_cloudModel.git && \
    git clone https://github.com/lsst/sims_downtimeModel.git && \
    git clone https://github.com/lsst/sims_utils.git && \
    git clone https://github.com/lsst/ephem.git && \
    git clone https://github.com/lsst/throughputs.git && \
    git clone https://github.com/lsst/sims_photUtils.git && \
    git clone https://github.com/lsst/sims_skybrightness.git && \
    git clone https://github.com/lsst/sims_skybrightness_pre.git && \
    git clone https://github.com/lsst-ts/ts_dateloc.git && \
    git clone https://github.com/lsst-ts/ts_astrosky_model.git && \
    git clone https://github.com/lsst-ts/ts_observatory_model.git && \
    git clone https://github.com/lsst-ts/scheduler_config.git && \
    git clone https://github.com/lsst/sims_skybrightness_data.git

WORKDIR /home/saluser/repos/sims_utils
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current && \
    setup sims_utils -t current && \
    scons

WORKDIR /home/saluser/repos/sims_cloudModel
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current && \
    setup sims_cloudModel -t current && \
    scons

WORKDIR /home/saluser/repos/sims_downtimeModel
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current && \
    setup sims_downtimeModel -t current && \
    scons

WORKDIR /home/saluser/repos/sims_seeingModel
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current && \
    setup sims_seeingModel -t current && \
    scons

WORKDIR /home/saluser/repos/sims_utils
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current && \
    setup sims_utils -t current && \
    scons

WORKDIR /home/saluser/repos/ephem
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    pip install pyephem && \
    eups declare -r . -t current

WORKDIR /home/saluser/repos/throughputs
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current

WORKDIR /home/saluser/repos/sims_photUtils
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current && \
    setup sims_photUtils -t current && \
    scons

WORKDIR /home/saluser/repos/sims_skybrightness_data
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current

WORKDIR /home/saluser/repos/sims_skybrightness
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current && \
    setup sims_skybrightness -t current && \
    scons

WORKDIR /home/saluser/repos/sims_skybrightness_pre
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current && \
    setup sims_skybrightness_pre -t current && \
    scons

WORKDIR /home/saluser/repos/ts_dateloc
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current && \
    setup ts_dateloc -t current && \
    scons

WORKDIR /home/saluser/repos/ts_astrosky_model
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current && \
    setup ts_astrosky_model -t current && \
    scons

WORKDIR /home/saluser/repos/ts_observatory_model
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current && \
    setup ts_observatory_model -t current && \
    scons

WORKDIR /home/saluser/repos/scheduler_config
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . -t current

WORKDIR /home/saluser/repos/ts_scheduler
RUN git fetch --all && git checkout "release/1.4"

WORKDIR /home/saluser/repos/ts_scheduler
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . -t current && setup ts_scheduler -t current && \
    py.test

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh

ENV INDEX=1

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
