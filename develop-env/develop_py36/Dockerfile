FROM lsstsqre/centos:7-stack-lsst_distrib-w_2019_08

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

USER root

# Create user and group
RUN adduser -u 1004 -m -g lsst -s /bin/bash saluser

COPY lsst-ts.repo /tmp/lsst-ts.repo
RUN cat /tmp/lsst-ts.repo >> /etc/yum.conf

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
  maven \
  which \
  gnome-terminal \
  mariadb \
  mariadb-devel \
  nano \
  emacs \
  ifconfig \
  gdb \
  ltrace\
  strace \
  net-tools \
  ntp \
  tcpdump && \
  yum clean all

RUN yum install -y OpenSpliceDDS-6.9.0-1

#RUN ln -s /opt/OpenSpliceDDS/ /opt/OpenSpliceDDS/V6.9

USER saluser
WORKDIR /home/saluser

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib &&\
    conda update -y -n base conda &&\
    conda install -y ipython jupyter jupyterlab tornado=4.5.3 jinja2 scipy ephem gitpython jsonschema=3.0.1 && \
    conda update -y pyqt fontconfig sqlalchemy && \
    cd ../ && \
    python -c 'import matplotlib.pyplot' && \
    conda clean -ay && pip install "documenteer[pipelines]==0.4.2" && pip install cmd2 && pip install asynccmd

RUN mkdir repos

WORKDIR /home/saluser/repos
RUN  git clone https://github.com/lsst-ts/ts_config_ocs.git && \
     git clone https://github.com/lsst-ts/o.git && \
     git clone https://github.com/lsst-ts/ts_sal.git && \
     git clone https://github.com/lsst-ts/ts_salobj.git && \
     git clone https://github.com/lsst-ts/ts_scriptqueue.git && \
     git clone https://github.com/lsst-ts/ts_xml.git && \
     git clone https://github.com/lsst-ts/ts_standardscripts.git && \
     git clone https://github.com/lsst-ts/ts_externalscripts.git && \
     git clone https://github.com/lsst-ts/ts_ATDome.git && \
     git clone https://github.com/lsst-ts/ts_ATDomeTrajectory.git

WORKDIR /home/saluser/repos/ts_sal
RUN git fetch && git checkout "tags/V3.9.0-5" -b "v3.9.0"

WORKDIR /home/saluser/repos/ts_salobj
RUN git fetch && git checkout "tags/v3.11.0" -b "v3.11.0"

WORKDIR /home/saluser/repos/ts_scriptqueue
RUN git fetch && git checkout "tags/v1.4.0" -b "v1.4.0"

WORKDIR /home/saluser/repos/ts_xml
RUN git fetch && git checkout "tags/v3.9" -b "v3.9"

WORKDIR /home/saluser

RUN source /opt/lsst/software/stack/loadLSST.bash && pip install --upgrade pycodestyle

ENV LSST_SDK_INSTALL=/home/saluser/repos/ts_sal
ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux
ENV PYTHON_BUILD_VERSION=3.6m
ENV PYTHON_BUILD_LOCATION=/opt/lsst/software/stack/python/miniconda3-4.5.4/
ENV LSST_DDS_DOMAIN=citest

WORKDIR /home/saluser/repos/ts_xml
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && eups declare -r . ts_xml -t current

USER saluser

WORKDIR /home/saluser/repos/ts_config_ocs
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . ts_config_ocs -t current && setup ts_config_ocs -t current

WORKDIR /home/saluser/repos/ts_config_attcs
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . ts_config_attcs -t current && setup ts_config_attcs -t current

WORKDIR /home/saluser/repos/ts_sal
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . ts_sal -t current && \
    setup ts_sal -t current && \
    mkdir -p $SAL_WORK_DIR && \
    mkdir -p $TS_SAL_DIR/lib && scons

WORKDIR /home/saluser/repos/ts_salobj
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    eups declare -r . ts_salobj -t current && setup ts_salobj -t current && scons

WORKDIR /home/saluser/repos/ts_scriptqueue
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    setup ts_sal -t current && \
    setup ts_salobj -t current && \
    make_salpy_libs.py ScriptQueue && \
    eups declare -r . ts_scriptqueue -t current && setup ts_scriptqueue -t current && \
    scons || echo Building scriptqueue failed. IGNORING...

#WORKDIR /home/saluser/repos/ts_ATDome
#RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
#    source /home/saluser/repos/ts_sal/setup.env && \
#    setup ts_salobj -t current && \
#    make_salpy_libs.py ATDome && \
#    eups declare -r . ts_ATDome -t current && setup ts_ATDome -t current && scons
#
#WORKDIR /home/saluser/repos/ts_ATDomeTrajectory
#RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
#    source /home/saluser/repos/ts_sal/setup.env && \
#    setup ts_salobj -t current && \
#    make_salpy_libs.py ATMCS ATDomeTrajectory && \
#    setup ts_config_attcs -t current && \
#    eups declare -r . ts_ATDomeTrajectory -t current && setup ts_ATDomeTrajectory -t current && scons
#
#WORKDIR /home/saluser/repos/ts_standardscripts
#RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
#    source /home/saluser/repos/ts_sal/setup.env && \
#    setup ts_sal -t current && \
#    setup ts_salobj -t current && \
#    setup ts_scriptqueue -t current && \
#    eups declare -r . ts_standardscripts -t current
#
#WORKDIR /home/saluser/repos/ts_externalscripts
#RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
#    source /home/saluser/repos/ts_sal/setup.env && \
#    setup ts_sal -t current && \
#    setup ts_salobj -t current && \
#    setup ts_scriptqueue -t current && \
#    setup ts_standardscripts -t current && \
#    eups declare -r . ts_externalscripts -t current

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
