FROM almalinux:8

COPY lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo

RUN yum install -y epel-release && \
  yum update -y && \
  yum install -y OpenSpliceDDS git screen && \
  yum clean all

ARG UID=73006
ARG GID=73006

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

USER root

RUN groupadd --gid ${GID} saluser && \
  adduser -u ${UID} -m -g ${GID} -s /bin/bash saluser

USER saluser
WORKDIR ${HOME}

RUN curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh && \
  chmod +x miniconda.sh && ./miniconda.sh -b -p ${HOME}/miniconda && \
  touch ${HOME}/.ospl_env.sh && \
  source /home/saluser/miniconda/bin/activate && \
  conda config --add channels conda-forge && \
  conda install -y python=3.8 && \
  conda install -y cython && \
  conda install -y numpy=1.20 astropy=4.1 && \
  conda install -y jupyterlab matplotlib ipympl && \
  conda install -y -c lsstts -c lsstts/label/dev ts-ddsconfig ts-salobj ts-dds ts-idl ts-utils ts-xml ts-mtdome && \
  echo export LSST_DDS_QOS=file://$(python -c "from lsst.ts import ddsconfig; print(ddsconfig.get_qos_path())") >> ${HOME}/.ospl_env.sh && \
  git clone https://github.com/lsst-ts/ts_config_mttcs.git

COPY jupyterlab.sh ${HOME}/jupyterlab.sh
COPY mtdome_csc.sh ${HOME}/mtdome_csc.sh
COPY notebooks ${HOME}/notebooks
COPY run_mtdome.py ${HOME}/run_mtdome.py
COPY start.sh ${HOME}/start.sh

# These need to be added to the ts_config_mttcs repository.
COPY _labels.yaml ${HOME}/ts_config_mttcs/MTDome/v1
COPY eie.yaml ${HOME}/ts_config_mttcs/MTDome/v1

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/start.sh"]
