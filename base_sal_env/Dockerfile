FROM lsstsqre/centos:7-stackbase-devtoolset-6

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

USER root

# Create user and group
RUN groupadd --gid 1000 lsst
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
  boost-devel \
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

RUN source scl_source enable devtoolset-6; \
    mkdir stack && \
    cd stack && \
    git clone https://github.com/lsst/lsstsw.git && \
    cd lsstsw && \
    unset PYTHONPATH && \
    ./bin/deploy

WORKDIR /home/saluser
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
RUN git fetch && git checkout "tags/v3.6.1" -b "v3.6.1"

WORKDIR /home/saluser/repos/ts_scriptqueue
RUN git fetch && git checkout "tags/v1.0.1" -b "v1.0.1"

WORKDIR /home/saluser/repos/ts_xml
RUN git fetch && git checkout "tags/v3.8.41" -b "v3.8.41"

WORKDIR /home/saluser

RUN source scl_source enable devtoolset-6 && source /home/saluser/stack/lsstsw/bin/setup.sh && \
    rebuild -t current sconsUtils

ENV LSST_SDK_INSTALL=/home/saluser/repos/ts_sal
ENV OSPL_HOME=/home/saluser/repos/ts_opensplice/OpenSpliceDDS/V6.4.1/HDE/x86_64.linux
ENV PYTHON_BUILD_VERSION=3.6m
ENV PYTHON_BUILD_LOCATION=/home/saluser/stack/lsstsw/miniconda
ENV LSST_DDS_DOMAIN=citest

WORKDIR /home/saluser/repos/ts_xml
RUN source scl_source enable devtoolset-6 && source /home/saluser/stack/lsstsw/bin/setup.sh && \
    eups declare -r . ts_xml -t current
#RUN source /home/saluser/stack/lsstsw/bin/setup.sh && setup lsst_distrib && eups declare -r . ts_xml -t $USER
#RUN source /home/saluser/stack/lsstsw/bin/setup.sh && eups declare -r . ts_xml -t $USER

#WORKDIR /home/saluser/repos
#RUN source scl_source enable devtoolset-6 && source /home/saluser/stack/lsstsw/bin/setup.sh && \
#    rebuild ts_sal && eups tags --clone bNNNN current

WORKDIR /home/saluser/repos/ts_sal
RUN source scl_source enable devtoolset-6 && source /home/saluser/stack/lsstsw/bin/setup.sh && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . ts_sal -t current && \
    setup ts_sal -t current && \
    mkdir -p $SAL_WORK_DIR && \
    mkdir -p $TS_SAL_DIR/lib &&\
    scons && \
    make_salpy_libs.py Script && \
    make_salpy_libs.py ScriptQueue

WORKDIR /home/saluser/repos/ts_salobj
RUN source scl_source enable devtoolset-6 && source /home/saluser/stack/lsstsw/bin/setup.sh && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    eups declare -r . ts_salobj -t current && setup ts_salobj -t current && scons

WORKDIR /home/saluser/repos/ts_scriptqueue
RUN source scl_source enable devtoolset-6 && source /home/saluser/stack/lsstsw/bin/setup.sh && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    setup ts_salobj -t current && \
    eups declare -r . ts_scriptqueue -t current && setup ts_scriptqueue -t current
    #scons || echo "ts_scriptqueue: Failed scons"

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh

#COPY setup_and_build.sh /home/saluser/.setup_and_build.sh
#COPY setup2.sh /home/saluser/setup_alternative.sh
#COPY setup_dds.env /home/saluser/setup_dds.env

#RUN pip install ipython
#RUN pip install jupyter
#RUN echo "echo source setup.sh to startupt" >> ~/.bashrc

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
