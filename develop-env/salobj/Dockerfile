ARG base_image_tag

FROM lsstts/base-env:$base_image_tag

USER saluser

COPY checkout_repo.sh /home/saluser/.checkout_repo.sh
COPY setup_env.sh /home/saluser/.setup_salobj.sh
COPY setup.sh /home/saluser/.setup.sh

USER root
RUN chown saluser:lsst /home/saluser/.setup_salobj.sh && \
    chmod a+x /home/saluser/.setup_salobj.sh && \
    chown saluser:lsst /home/saluser/.checkout_repo.sh && \
    chmod a+x /home/saluser/.checkout_repo.sh && \
    chown saluser:lsst /home/saluser/.setup.sh && \
    chmod a+x /home/saluser/.setup.sh

USER saluser

RUN source /home/saluser/.setup_salobj.sh && \
    mkdir $EUPS_PATH/../tssw && \
    ln -s $EUPS_PATH/../tssw repos

# Arguments for package versions
ARG ts_config_ocs="develop"
ARG ts_config_attcs="develop"
ARG ts_config_mtcalsys="develop"
ARG ts_config_eas="develop"
ARG ts_config_latiss="develop"
ARG ts_config_mttcs="develop"
ARG ts_config_atcalsys="develop"
ARG ts_xml="develop"
ARG ts_idl="develop"
ARG ts_sal="develop"
ARG ts_salobj="develop"

RUN source /home/saluser/.setup_salobj.sh && \
    cd $EUPS_PATH/../tssw && \
    gitsrc="ts_config_ocs:${ts_config_ocs} \
            ts_config_attcs:${ts_config_attcs} \
            ts_config_mtcalsys:${ts_config_mtcalsys} \
            ts_config_eas:${ts_config_eas} \
            ts_config_latiss:${ts_config_latiss} \
            ts_config_mttcs:${ts_config_mttcs} \
            ts_config_atcalsys:${ts_config_atcalsys} \
            ts_xml:${ts_xml} \
            ts_idl:${ts_idl} \
            ts_sal:${ts_sal} \
            ts_salobj:${ts_salobj}" && \
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

WORKDIR /home/saluser/repos/ts_sal
RUN source /home/saluser/.setup_salobj.sh && \
    eups declare -r . ts_sal -t current && \
    setup ts_idl -t current && \
    setup ts_sal -t current && \
    mkdir -p $SAL_WORK_DIR && \
    mkdir -p $TS_SAL_DIR/lib && scons || pytest --color=no --lf

WORKDIR /home/saluser/
RUN source /home/saluser/.setup_salobj.sh && \
    pip install ts-dds=="6.9.181127"

WORKDIR /home/saluser/
RUN source /home/saluser/.setup_salobj.sh && \
    setup ts_sal -t current && \
    setup ts_idl -t current && \
    make_idl_files.py Test Script LOVE && \
    make_salpy_libs.py Test Script

WORKDIR /home/saluser/repos/ts_salobj
RUN source /home/saluser/.setup_salobj.sh && \
    setup ts_sal -t current && \
    setup ts_idl -t current && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    eups declare -r . ts_salobj -t current && \
    setup ts_salobj -t current && \
    scons || pytest --color=no --lf

WORKDIR /home/saluser/

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
