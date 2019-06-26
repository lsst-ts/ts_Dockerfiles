ARG base_image_tag

FROM lsstts/base-env:$base_image_tag

RUN mkdir repos

WORKDIR /home/saluser/repos
RUN  git clone https://github.com/lsst-ts/ts_config_ocs.git && \
     git clone https://github.com/lsst-ts/ts_sal.git && \
     git clone https://github.com/lsst-ts/ts_salobj.git && \
     git clone https://github.com/lsst-ts/ts_xml.git && \
     git clone https://github.com/lsst-ts/ts_idl.git

# Arguments for package versions
ARG config_ocs_v="tags/v0.0-alpha.0"
ARG sal_v="tags/v3.10.0"
ARG salobj_v="tags/v4.2.0"
ARG xml_v="tags/v3.10.0"
ARG idl_v="develop"

WORKDIR /home/saluser/repos/ts_config_ocs
RUN git_v=${config_ocs_v} && \
    git fetch --all && \
    if [[ ${git_v} == tags/* ]] ; \
    then \
        echo checkout ${git_v} -b $git_v ; \
        git checkout ${git_v} -b $git_v ; \
    else \
        echo checkout ${git_v} ; \
        git checkout ${git_v} ; \
    fi

WORKDIR /home/saluser/repos/ts_sal
RUN git_v=${sal_v} && \
    git fetch --all && \
    if [[ ${git_v} == tags/* ]] ; \
    then \
        echo checkout ${git_v} -b $git_v ; \
        git checkout ${git_v} -b $git_v ; \
    else \
        echo checkout ${git_v} ; \
        git checkout ${git_v} ; \
    fi

WORKDIR /home/saluser/repos/ts_salobj
RUN git_v=${salobj_v} && \
    git fetch --all && \
    if [[ ${git_v} == tags/* ]] ; \
    then \
        echo checkout ${git_v} -b $git_v ; \
        git checkout ${git_v} -b $git_v ; \
    else \
        echo checkout ${git_v} ; \
        git checkout ${git_v} ; \
    fi

WORKDIR /home/saluser/repos/ts_xml
RUN git_v=${xml_v} && \
    git fetch --all && \
    if [[ ${git_v} == tags/* ]] ; \
    then \
        echo checkout ${git_v} -b $git_v ; \
        git checkout ${git_v} -b $git_v ; \
    else \
        echo checkout ${git_v} ; \
        git checkout ${git_v} ; \
    fi

WORKDIR /home/saluser/repos/ts_idl
RUN git_v=${idl_v} && \
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

ENV LSST_SDK_INSTALL=/home/saluser/repos/ts_sal
ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux
ENV PYTHON_BUILD_VERSION=3.6m
ENV PYTHON_BUILD_LOCATION=/opt/lsst/software/stack/python/miniconda3-4.5.4/
ENV LSST_DDS_DOMAIN=citest

WORKDIR /home/saluser/repos/ts_config_ocs
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . ts_config_ocs -t current && setup ts_config_ocs -t current

WORKDIR /home/saluser/repos/ts_xml
RUN source /opt/lsst/software/stack/loadLSST.bash && \
    setup lsst_distrib && \
    eups declare -r . ts_xml -t current

USER saluser

WORKDIR /home/saluser/repos/ts_sal
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . ts_sal -t current && \
    setup ts_sal -t current && \
    mkdir -p $SAL_WORK_DIR && \
    mkdir -p $TS_SAL_DIR/lib && scons

WORKDIR /home/saluser/repos/ts_idl
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    eups declare -r . ts_idl -t current && setup ts_idl -t current && scons

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
    make_idl_files.py Test Script

WORKDIR /home/saluser/repos/ts_salobj
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    setup ts_idl -t current && \
    eups declare -r . ts_salobj -t current && setup ts_salobj -t current && scons

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
