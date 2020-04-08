ARG base_image_tag

FROM lsstts/base-env:$base_image_tag

USER saluser

COPY checkout_repo.sh /home/saluser/.checkout_repo.sh

RUN mkdir repos

WORKDIR /home/saluser/repos
RUN  git clone https://github.com/lsst-ts/ts_config_ocs.git && \
     git clone https://github.com/lsst-ts/ts_config_attcs.git && \
     git clone https://github.com/lsst-ts/ts_config_mtcalsys.git && \
     git clone https://github.com/lsst-ts/ts_config_eas.git && \
     git clone https://github.com/lsst-ts/ts_config_latiss.git && \
     git clone https://github.com/lsst-ts/ts_config_mttcs.git && \
     git clone https://github.com/lsst-ts/ts_config_atcalsys.git && \
     git clone https://github.com/lsst-ts/ts_sal.git && \
     git clone https://github.com/lsst-ts/ts_salobj.git && \
     git clone https://github.com/lsst-ts/ts_xml.git && \
     git clone https://github.com/lsst-ts/ts_idl.git

# Arguments for package versions
ARG config_ocs_v="develop"
ARG config_attcs_v="develop"
ARG config_mtcalsys_v="develop"
ARG config_eas_v="develop"
ARG config_latiss_v="develop"
ARG config_mttcs_v="develop"
ARG config_atcalsys_v="develop"
ARG sal_v="develop"
ARG salobj_v="develop"
ARG xml_v="develop"
ARG idl_v="develop"

WORKDIR /home/saluser/repos/ts_config_ocs
RUN /home/saluser/.checkout_repo.sh ${config_ocs_v}

WORKDIR /home/saluser/repos/ts_config_attcs
RUN /home/saluser/.checkout_repo.sh ${config_attcs_v}

WORKDIR /home/saluser/repos/ts_config_mtcalsys
RUN /home/saluser/.checkout_repo.sh ${config_mtcalsys_v}

WORKDIR /home/saluser/repos/ts_config_eas
RUN /home/saluser/.checkout_repo.sh ${config_eas_v}

WORKDIR /home/saluser/repos/ts_config_latiss
RUN /home/saluser/.checkout_repo.sh ${config_latiss_v}

WORKDIR /home/saluser/repos/ts_config_mttcs
RUN /home/saluser/.checkout_repo.sh ${config_mttcs_v}

WORKDIR /home/saluser/repos/ts_config_atcalsys
RUN /home/saluser/.checkout_repo.sh ${config_atcalsys_v}

WORKDIR /home/saluser/repos/ts_sal
RUN /home/saluser/.checkout_repo.sh ${sal_v}

WORKDIR /home/saluser/repos/ts_salobj
RUN /home/saluser/.checkout_repo.sh ${salobj_v}

WORKDIR /home/saluser/repos/ts_xml
RUN /home/saluser/.checkout_repo.sh ${xml_v}

WORKDIR /home/saluser/repos/ts_idl
RUN /home/saluser/.checkout_repo.sh ${idl_v}

WORKDIR /home/saluser

WORKDIR /home/saluser/repos/ts_config_ocs
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . -t current

WORKDIR /home/saluser/repos/ts_config_attcs
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . -t current

WORKDIR /home/saluser/repos/ts_config_mtcalsys
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . -t current

WORKDIR /home/saluser/repos/ts_config_eas
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . -t current

WORKDIR /home/saluser/repos/ts_config_latiss
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . -t current

WORKDIR /home/saluser/repos/ts_config_mttcs
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . -t current

WORKDIR /home/saluser/repos/ts_config_atcalsys
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . -t current

WORKDIR /home/saluser/repos/ts_xml
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    setup lsst_distrib && \
    eups declare -r . -t current

WORKDIR /home/saluser/repos/ts_idl
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    eups declare -r . ts_idl -t current

WORKDIR /home/saluser/repos/ts_sal
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . ts_sal -t current && \
    setup ts_sal -t current && \
    mkdir -p $SAL_WORK_DIR && \
    mkdir -p $TS_SAL_DIR/lib && scons || pytest

WORKDIR /home/saluser/repos
RUN mkdir dds
WORKDIR /home/saluser/repos/dds/
RUN tar zxvf /opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux/tools/python-support.tgz
WORKDIR /home/saluser/repos/dds/python/src/
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    setup ts_idl -t current && \
    source /home/saluser/repos/ts_sal/setup.env && \
    python setup.py install

WORKDIR /home/saluser/
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    setup ts_idl -t current && \
    make_idl_files.py Test Script LOVE && \
    make_salpy_libs.py Test Script

WORKDIR /home/saluser/repos/ts_salobj
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    setup ts_idl -t current && \
    export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'` && \
    eups declare -r . ts_salobj -t current && setup ts_salobj -t current && \
    pytest --color=no || pytest --color=no --lf

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
