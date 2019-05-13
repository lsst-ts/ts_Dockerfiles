FROM centos:centos7

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

USER root

# Create user and group
RUN groupadd lsst && adduser -u 1004 -m -g lsst -s /bin/bash saluser

COPY lsst-ts.repo /tmp/lsst-ts.repo
RUN cat /tmp/lsst-ts.repo >> /etc/yum.conf

RUN yum install -y https://centos7.iuscommunity.org/ius-release.rpm

RUN yum -y --enablerepo=extras install epel-release \
  bzip2 \
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
  devtoolset-3 && \
  yum clean all

RUN yum install -y ATPtg-3.9.0 \
    MTPtg-3.9.0 \
    MTMount-3.9.0 \
    Rotator-3.9.0 \
    Environment-3.9.0 \
    ATMCS-3.9.0


RUN mkdir /home/saluser/.ssh/ && chown saluser:lsst /home/saluser/.ssh/ && chmod 700 /home/saluser/.ssh/
COPY id_rsa /home/saluser/.ssh/
COPY known_hosts /home/saluser/.ssh/
RUN chown saluser:lsst /home/saluser/.ssh/id_rsa && chown saluser:lsst /home/saluser/.ssh/known_hosts

USER saluser
WORKDIR /home/saluser

RUN mkdir repos

WORKDIR /home/saluser/repos

##RUN ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no git@github.com || \
## echo "ssh command skipping..."
RUN git clone git@github.com:lsst-ts/tcspk_source_lsst_161203.git && \
 git clone git@github.com:lsst-ts/slalib_source_lsst_161203.git && \
 git clone git@github.com:lsst-ts/ts_pointing_common.git

WORKDIR /home/saluser/repos/ts_pointing_common
RUN git checkout "tags/RC_v0.3" -b "RC_v0.3"

WORKDIR /home/saluser

ENV LSST_SDK_INSTALL=/opt/lsst/ts_sal/
ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux
ENV PYTHON_BUILD_VERSION=3.6m
ENV PYTHON_BUILD_LOCATION=/opt/lsst/software/stack/python/miniconda3-4.5.4/
ENV LSST_DDS_DOMAIN=citest
ENV PYTHONPATH=${PYTHONPATH}:/opt/lsst/ts_sal/lib/
ENV PTG_CONFIG_DIR=/home/saluser/repos/ts_pointing_common/install/data
ENV PTG_DATA_DIR=/home/saluser/repos/ts_pointing_common/install/data
ENV LSST_TOP=/home/saluser/repos/ts_pointing_common
ENV SLALIB_DIR=/home/saluser/repos/slalib_source_lsst_161203
ENV TCSPK_DIR=/home/saluser/repos/tcspk_source_lsst_161203
ENV LSST_TS_XML_DIR=/home/saluser/repos/ts_xml

#RUN ./scripts/generate_interface && mkdir build && cd build && cmake -DAT=ON .. && make && cmake .. && make
WORKDIR /home/saluser/repos/slalib_source_lsst_161203
RUN make

WORKDIR /home/saluser/repos/tcspk_source_lsst_161203
RUN make

WORKDIR /home/saluser/repos/ts_pointing_common
#RUN git fetch && git checkout "origin/feature/AY/SAL_v3.8" -b "feature/AY/SAL_v3.8"
#RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
#    source $LSST_SDK_INSTALL/setup.env && setup ts_sal -t $USER && \
#    ./scripts/generate_interface
#
#RUN mkdir -p $PTG_DATA_DIR && cp $LSST_TOP/src/data/* $PTG_DATA_DIR/
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
#WORKDIR /home/saluser/repos/ts_pointing_common
#RUN source scl_source enable devtoolset-3 && \
#    source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
#    source $LSST_SDK_INSTALL/setup.env && setup ts_sal -t $USER && \
#    mkdir build && cd build && cmake -DAT=ON .. && make && cmake .. && make

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
#CMD ["/home/saluser/.setup.sh"]
