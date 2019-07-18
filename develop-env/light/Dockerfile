FROM centos:centos7

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

USER root

# Create user and group
RUN adduser -u 1004 -m -s /bin/bash saluser

RUN yum install -y https://centos7.iuscommunity.org/ius-release.rpm

RUN yum -y --enablerepo=extras install epel-release \
    bison \
    blas \
    bzip2 \
    bzip2-devel \
    cmake \
    curl \
    flex \
    fontconfig \
    freetype-devel \
    gawk \
    gcc-c++ \
    gcc-gfortran \
    gettext \
    git \
    glib2-devel \
    java-1.8.0-openjdk \
    libcurl-devel \
    libuuid-devel \
    libXext \
    libXrender \
    libXt-devel \
    make \
    mesa-libGL \
    ncurses-devel \
    openssl-devel \
    patch \
    perl \
    perl-ExtUtils-MakeMaker \
    readline-devel \
    sed \
    tar \
    which \
    zlib-devel \
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

COPY lsst-ts.repo /tmp/lsst-ts.repo
RUN cat /tmp/lsst-ts.repo >> /etc/yum.conf

RUN yum install -y OpenSpliceDDS-6.9.0-1

USER saluser
WORKDIR /home/saluser

RUN mkdir /home/saluser/repos

WORKDIR /home/saluser/repos

RUN git clone https://github.com/lsst/lsst.git

RUN mkdir /home/saluser/repos/stack

WORKDIR /home/saluser/repos/stack

RUN bash /home/saluser/repos/lsst/scripts/newinstall.sh -ctb

RUN source "/home/saluser/repos/stack/loadLSST.bash" && \
    conda create -n py36 python=3.6 && \
    conda activate py36 && \
    conda install -y ipython jupyter jupyterlab tornado=4.5.3 jinja2 scipy \
        ephem gitpython jsonschema=3.0.1 pyqt fontconfig sqlalchemy matplotlib && \
    cd ../ && \
    python -c 'import matplotlib.pyplot' && \
    conda clean -ay && pip install "documenteer[pipelines]==0.4.2" && pip install cmd2 && pip install asynccmd

WORKDIR /home/saluser/repos
RUN  git clone https://github.com/lsst-ts/ts_config_ocs.git && \
     git clone https://github.com/lsst-ts/ts_config_attcs.git && \
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

ENV LSST_SDK_INSTALL=/home/saluser/repos/ts_sal
ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux
ENV PYTHON_BUILD_VERSION=3.6m
ENV PYTHON_BUILD_LOCATION=/home/saluser/repos/stack/python/miniconda3-4.5.12/envs/py36/
ENV LSST_DDS_DOMAIN=citest

WORKDIR /home/saluser/repos/ts_xml
RUN source "/home/saluser/repos/stack/loadLSST.bash" && \
    conda activate py36 && eups declare -r . ts_xml -t current

USER saluser

WORKDIR /home/saluser/repos/ts_config_ocs
RUN source "/home/saluser/repos/stack/loadLSST.bash" && \
    conda activate py36 && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . ts_config_ocs -t current && setup ts_config_ocs -t current

WORKDIR /home/saluser/repos/ts_config_attcs
RUN source "/home/saluser/repos/stack/loadLSST.bash" && \
    conda activate py36 && \
    source /home/saluser/repos/ts_sal/setup.env && \
    eups declare -r . ts_config_attcs -t current && setup ts_config_attcs -t current

#WORKDIR /home/saluser/repos/ts_sal
#RUN source "/home/saluser/repos/stack/loadLSST.bash" && \
#    conda activate py36 && \
#    source /home/saluser/repos/ts_sal/setup.env && \
#    eups declare -r . ts_sal -t current && \
#    setup ts_sal -t current && \
#    mkdir -p $SAL_WORK_DIR && \
#    mkdir -p $TS_SAL_DIR/lib && scons

WORKDIR /home/saluser/
