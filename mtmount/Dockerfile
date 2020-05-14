FROM centos:centos7

LABEL maintainer Andrew Heyer <aheyer@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser
USER root
# Create user and group
RUN groupadd lsst && adduser -u 1004 -m -g lsst -s /bin/bash saluser

COPY lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts-nexus.repo
COPY wandisco-git.repo /etc/yum.repos.d/wandisco-git.repo
RUN rpm --import http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco
RUN yum install -y git wget
RUN yum install -y OpenSpliceDDS-6.9.0

#RUN yum update
RUN yum groupinstall -y "Development Tools"
RUN yum install -y cmake boost-devel.x86_64
RUN wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -ivh epel-release-latest-7.noarch.rpm
RUN yum install -y geany java-1.7.0-openjdk-devel

RUN yum install -y glibc.i686 libstdc++.so.6 libXinerama.i686 && \
yum upgrade -y gnome-packagekit-common && \
yum install -y libglvnd-glx-1.0.1-0.8.git5baa1e5.el7.i686

RUN yum install -y yum-utils device-mapper-persistent-data lvm2

RUN yum install -y which python3-devel tcl tcl-devel


COPY lsst ${HOME}/lsst
RUN chown saluser:lsst -R ${HOME}/lsst/


USER saluser
WORKDIR ${HOME}
RUN mkdir repos
WORKDIR /home/saluser/repos
RUN  git clone https://github.com/lsst-ts/ts_sal.git && \
     git clone https://github.com/lsst-ts/ts_xml.git 
ENV LSST_SDK_INSTALL=/home/saluser/repos/ts_sal
ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux
ENV LSST_DDS_DOMAIN=citest

RUN source /home/saluser/repos/ts_sal/setup.env && \ 
    mkdir -p $SAL_WORK_DIR && \
    mkdir -p $TS_SAL_DIR/lib

WORKDIR ${HOME}/repos/ts_xml
RUN git checkout feature/julen/CCWAuxTesting

WORKDIR /home/saluser/repos/ts_sal/test
RUN source ${HOME}/repos/ts_sal/setup.env && \
    cp ../../ts_xml/sal_interfaces/SAL* . && \
    cp ../../ts_xml/sal_interfaces/MTMount/MTMount_* . && \
    cp ../../ts_xml/sal_interfaces/Rotator/Rotator_* . && \
    salgenerator MTMount validate && \
    salgenerator MTMount html && \
    salgenerator MTMount sal cpp && \
    salgenerator Rotator validate && \
    salgenerator Rotator html && \
    salgenerator Rotator sal cpp

WORKDIR ${HOME}/lsst
RUN git checkout feature-rotator-track
WORKDIR ${HOME}/lsst/tma_management
RUN mkdir build
WORKDIR ${HOME}/lsst/tma_management/build
RUN source ${HOME}/repos/ts_sal/setup.env && \
    cmake .. && \
    make


WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh
ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]

