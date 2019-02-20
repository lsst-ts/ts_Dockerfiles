FROM lsstsqre/centos:7-stack-lsst_distrib-v16_0

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

USER root

# Create user and group
RUN adduser -u 1004 -m -g lsst -s /bin/bash saluser

RUN yum install -y https://centos7.iuscommunity.org/ius-release.rpm

RUN yum -y --enablerepo=extras install epel-release \
  unzip \
  wget \
  git \
  dos2unix \
  tk \
  tk-devel \
  swig \
  ncurses-libs \
  xterm \
  xorg-x11-fonts-misc \
  java-1.8.0-openjdk-devel \
  boost-python \
  boost-python-devel \
  maven \
  which \
  gnome-terminal \
  mariadb \
  mariadb-devel \
  nano \
  emacs && \
  yum clean all

USER saluser
WORKDIR /home/saluser

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib &&\
    conda install -y ipython jupyter jupyterlab tornado=4.5.3 jinja2 scipy ephem gitpython && \
    conda update -y pyqt fontconfig sqlalchemy && \
    cd ../ && \
    python -c 'import matplotlib.pyplot' && \
    conda clean -ay && pip install "documenteer[pipelines]==0.4.2"

RUN mkdir repos

WORKDIR /home/saluser/repos
RUN git clone https://github.com/lsst-ts/ts_opensplice.git && \
git clone https://github.com/lsst-ts/ts_sal.git && \
git clone https://github.com/lsst-ts/ts_salobj.git && \
git clone https://github.com/lsst-ts/ts_scriptqueue.git && \
git clone https://github.com/lsst-ts/ts_xml.git

WORKDIR /home/saluser/repos/ts_sal
RUN git fetch && git checkout "tags/v3.8.41" -b "v3.8.41"

WORKDIR /home/saluser/repos/ts_salobj
RUN git fetch && git checkout "tags/v3.7.1" -b "v3.8.0"

WORKDIR /home/saluser/repos/ts_scriptqueue
RUN git fetch && git checkout "tags/v1.1.0" -b "v1.1.0"

WORKDIR /home/saluser/repos/ts_xml
RUN git fetch && git checkout "tags/v3.8.41" -b "v3.8.41"

WORKDIR /home/saluser

RUN source /opt/lsst/software/stack/loadLSST.bash && pip install --upgrade pycodestyle

ENV LSST_SDK_INSTALL=/home/saluser/repos/ts_sal
ENV OSPL_HOME=/home/saluser/repos/ts_opensplice/OpenSpliceDDS/V6.4.1/HDE/x86_64.linux
ENV PYTHON_BUILD_VERSION=3.6m
ENV PYTHON_BUILD_LOCATION=/opt/lsst/software/stack/python/miniconda3-4.3.21/
ENV LSST_DDS_DOMAIN=citest

WORKDIR /home/saluser/repos/ts_xml
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && eups declare -r . ts_xml -t $USER

WORKDIR /home/saluser/repos/ts_sal
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . ts_sal -t $USER && \
    setup ts_sal -t $USER && \
    mkdir -p $SAL_WORK_DIR && \
    mkdir -p $TS_SAL_DIR/lib &&\
    scons && \
    make_salpy_libs.py Script ScriptQueue LinearStage TunableLaser Electrometer ATCamera

WORKDIR /home/saluser/repos/ts_salobj
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t $USER && \
    eups declare -r . ts_salobj -t $USER && setup ts_salobj -t $USER && scons

WORKDIR /home/saluser/repos/ts_scriptqueue
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t $USER && \
    setup ts_salobj -t $USER && \
    eups declare -r . ts_scriptqueue -t $USER && setup ts_scriptqueue -t $USER

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
