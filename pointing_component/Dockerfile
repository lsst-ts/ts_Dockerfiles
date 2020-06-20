FROM lsstsqre/centos:7-stack-lsst_distrib-v16_0

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

USER root

# Create user and group
RUN adduser -u 1004 -m -g lsst -s /bin/bash saluser

RUN yum install -y https://repo.ius.io/ius-release-el7.rpm

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
  emacs \
  cmake \
  devtoolset-4 \
  devtoolset-3 && \
  yum clean all

RUN mkdir /home/saluser/.ssh/ && chown saluser:lsst /home/saluser/.ssh/ && chmod 700 /home/saluser/.ssh/
COPY id_rsa /home/saluser/.ssh/
COPY known_hosts /home/saluser/.ssh/
RUN chown saluser:lsst /home/saluser/.ssh/id_rsa && chown saluser:lsst /home/saluser/.ssh/known_hosts

USER saluser
WORKDIR /home/saluser

#RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib &&\
#    conda install -y ipython jupyter jupyterlab tornado=4.5.3 jinja2 scipy ephem gitpython && \
#    conda update -y pyqt fontconfig sqlalchemy && \
#    cd ../ && \
#    python -c 'import matplotlib.pyplot' && \
#    conda clean -ay && pip install "documenteer[pipelines]==0.4.2"

RUN mkdir repos

WORKDIR /home/saluser/repos
#RUN ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no git@github.com || \
# echo "ssh command skipping..."
RUN git clone https://github.com/lsst-ts/ts_opensplice.git && \
 git clone https://github.com/lsst-ts/ts_sal.git && \
 git clone https://github.com/lsst-ts/ts_xml.git && \
 git clone git@github.com:lsst-ts/tcspk_source_lsst_161203.git && \
 git clone git@github.com:lsst-ts/slalib_source_lsst_161203.git && \
 git clone git@github.com:lsst-ts/ts_pointing_common.git

WORKDIR /home/saluser/repos/ts_sal
RUN git fetch && git checkout "tags/v3.8.41" -b "v3.8.41"

WORKDIR /home/saluser/repos/ts_xml
RUN git fetch && git checkout "tags/v3.9" -b "v3.9"

WORKDIR /home/saluser

RUN source /opt/lsst/software/stack/loadLSST.bash && pip install --upgrade pycodestyle

ENV LSST_SDK_INSTALL=/home/saluser/repos/ts_sal
ENV OSPL_HOME=/home/saluser/repos/ts_opensplice/OpenSpliceDDS/V6.4.1/HDE/x86_64.linux
ENV PYTHON_BUILD_VERSION=3.6m
ENV PYTHON_BUILD_LOCATION=/opt/lsst/software/stack/python/miniconda3-4.3.21/
ENV LSST_DDS_DOMAIN=citest
ENV PTG_CONFIG_DIR=/home/saluser/repos/ts_pointing_common/install/data
ENV PTG_DATA_DIR=/home/saluser/repos/ts_pointing_common/install/data
ENV LSST_TOP=/home/saluser/repos/ts_pointing_common
ENV SLALIB_DIR=/home/saluser/repos/slalib_source_lsst_161203
ENV TCSPK_DIR=/home/saluser/repos/tcspk_source_lsst_161203
ENV LSST_TS_XML_DIR=/home/saluser/repos/ts_xml

#WORKDIR /home/saluser/repos/ts_pointing_common
#RUN ./scripts/generate_interface && mkdir build && cd build && cmake -DAT=ON .. && make && cmake .. && make
WORKDIR /home/saluser/repos/ts_xml
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && eups declare -r . ts_xml -t $USER

WORKDIR /home/saluser/repos/ts_sal
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . ts_sal -t $USER && \
    setup ts_sal -t $USER && \
    mkdir -p $SAL_WORK_DIR && \
    mkdir -p $TS_SAL_DIR/lib &&\
    scons

WORKDIR /home/saluser/repos/slalib_source_lsst_161203
RUN make

WORKDIR /home/saluser/repos/tcspk_source_lsst_161203
RUN make

WORKDIR /home/saluser/repos/ts_pointing_common
RUN git checkout "tags/RC_v0.3" -b "RC_v0.3"

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source $LSST_SDK_INSTALL/setup.env && setup ts_sal -t $USER && \
    ./scripts/generate_interface

RUN mkdir -p $PTG_DATA_DIR && cp $LSST_TOP/src/data/* $PTG_DATA_DIR/
#WORKDIR /home/saluser/repos/ts_xml
#RUN git checkout develop && git pull && \
#    cp -v sal_interfaces/ATMCS/ATMCS_*xml /home/saluser/repos/ts_sal/test
#WORKDIR /home/saluser/repos/ts_sal/test
#RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
#    source /home/saluser/repos/ts_sal/setup.env && \
#    setup ts_sal -t $USER && \
#    salgenerator ATMCS validate && \
#    salgenerator ATMCS html && \
#    salgenerator ATMCS sal cpp && \
#    salgenerator ATMCS sal python && \
#    salgenerator ATMCS lib

WORKDIR /home/saluser/repos/ts_pointing_common
RUN source scl_source enable devtoolset-3 && \
    source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    source $LSST_SDK_INSTALL/setup.env && setup ts_sal -t $USER && \
    mkdir build && cd build && cmake -DAT=ON .. && make && cmake .. && make

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
