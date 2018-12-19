FROM centos:7

LABEL authors="Andres Anania <aanania@lsst.org>"

# install required software
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
  boost \
  boost-devel \
  cmake \
  maven \
  python36-devel \
  python36-setuptools \
  xorg-x11-server-Xvfb \
  which \
  gnome-terminal \
  nano && \
  yum clean all
RUN yum groupinstall -y "Development Tools" "Development Libraries" "X Window System" && \
  yum clean all

RUN ln -s /usr/include/python3.6m/ /usr/local/include/python3.6m

# environment variables section
ENV HOME=/home/docker
ENV LSST_SDK_INSTALL=$HOME/ts_sal
ENV SAL_HOME=$LSST_SDK_INSTALL/lsstsal
ENV SAL_WORK_DIR=$LSST_SDK_INSTALL/test
ENV SAL_CPPFLAGS=-m64
ENV JAVA_HOME=/etc/alternatives/java_sdk_openjdk
ENV LD_LIBRARY_PATH=${SAL_HOME}/lib
ENV TCL_LIBRARY=${SAL_HOME}/lib/tcl8.5
ENV TK_LIBRARY=${SAL_HOME}/lib/tk8.5
ENV LD_PRELOAD=/etc/alternatives/java_sdk_openjdk/jre/lib/amd64/libjsig.so
ENV PATH=$JAVA_HOME/bin:${M2}:${SAL_HOME}/bin:${PATH}
ENV PYTHONPATH=$PYTHONPATH:${SAL_WORK_DIR}/lib
ENV SAL_DIR=${SAL_HOME}/scripts
ENV PATH=${PATH}:${SAL_DIR}
ENV OSPL_HOME=$HOME/ts_opensplice/OpenSpliceDDS/V6.4.1/HDE/x86_64.linux
ENV PYTHON_BUILD_VERSION=3.6m
ENV PYTHON_BUILD_LOCATION=/usr/local

ENV CPLUS_INCLUDE_PATH=${CPLUS_INCLUDE_PATH}:/home/docker/ts_sal/test/include

#Pointing paths
ENV SLALIB_DIR=$HOME/slalib_source_lsst_161203
ENV LSST_TOP=$HOME/ts_pointing_common
ENV TCSPK_DIR=$HOME/tcspk_source_lsst_161203/
ENV PTG_CONFIG_DIR=$HOME/ts_pointing_common/install/data
ENV PTG_DATA_DIR=$HOME/ts_pointing_common/install/data

ENV DISPLAY=:99

COPY requirements.txt /home/docker/requirements.txt

ADD ./slalib_source_lsst_161203 /home/docker/slalib_source_lsst_161203
WORKDIR /home/docker/slalib_source_lsst_161203
RUN make

ADD ./tcspk_source_lsst_161203 /home/docker/tcspk_source_lsst_161203
WORKDIR /home/docker/tcspk_source_lsst_161203
RUN make

WORKDIR /home/docker/
RUN git clone https://github.com/lsst-ts/ts_opensplice.git
WORKDIR /home/docker/ts_opensplice
RUN git checkout d804a898a5cc0420b9b2ac42b1b42416efe3d749

ADD ./ts_pointing_common /home/docker/ts_pointing_common

WORKDIR /home/docker/
RUN git clone https://github.com/lsst-ts/ts_sal.git -b Release-V3.7.1

COPY run.sh /home/docker/run.sh

RUN sed -i 's/ATPtg/ATPtg ATMCS/g' /home/docker/ts_sal/lsstsal/scripts/add_system_dictionary.tcl
RUN easy_install-3.6 pip
RUN pip3 install -r /home/docker/requirements.txt
RUN source /home/docker/ts_sal/setup.env; /home/docker/ts_pointing_common/scripts/generate_interface_AT

WORKDIR /home/docker/ts_pointing_common
RUN mkdir -p build
WORKDIR /home/docker/ts_pointing_common/build
RUN cmake -DAT=ON ..
RUN source /home/docker/ts_sal/setup.env; make
RUN source /home/docker/ts_sal/setup.env; make install
RUN dbus-uuidgen >/etc/machine-id

