FROM centos:centos7


ARG rpm=0:4.1.0-5.0.0.el7.x86_64
ARG ptg=v2.0.0

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

USER root

# Create user and group
RUN groupadd lsst && adduser -u 1004 -m -g lsst -s /bin/bash saluser

COPY lsst-ts.repo /etc/yum.repos.d/lsst-ts.repo

RUN yum install -y https://repo.ius.io/ius-release-el7.rpm && \
    yum install -y centos-release-scl cmake

RUN yum -y --enablerepo=extras install epel-release \
    devtoolset-8-gcc* \
    wget \
    git \
    make \
    wget \
    OpenSpliceDDS-6.9.0 \
    boost-python \
    boost-python-devel \
    curl-devel \
    yum clean all

RUN yum install -y ATPtg-${rpm} \
    MTPtg-${rpm} \
    MTMount-${rpm} \
    Rotator-${rpm} \
    Environment-${rpm} \
    ATMCS-${rpm} \
    NewMTMount-${rpm}

RUN mkdir /home/saluser/.ssh/ && chown saluser:lsst /home/saluser/.ssh/ && chmod 700 /home/saluser/.ssh/
COPY id_rsa /home/saluser/.ssh/
COPY known_hosts /home/saluser/.ssh/
RUN chown saluser:lsst /home/saluser/.ssh/id_rsa && \
    chown saluser:lsst /home/saluser/.ssh/known_hosts && \
    chmod 400 /home/saluser/.ssh/id_rsa

#RUN mkdir /opt/lsst/ts_sal/lsstsal/ && \
#    ln -s /opt/lsst/ts_sal/include /opt/lsst/ts_sal/lsstsal/include && \
#    ln -s /opt/lsst/ts_sal/lib /opt/lsst/ts_sal/lsstsal/lib && \
#    mkdir /opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux/examples/ && \
#    ln -s /opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux/include/ /opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux/examples/include && \
#    cd /opt/lsst/ts_sal/include &&\
#    curl -O https://raw.githubusercontent.com/lsst-ts/ts_sal/develop/lsstsal/include/os.h && \
#    curl -O https://raw.githubusercontent.com/lsst-ts/ts_sal/develop/lsstsal/include/example_main.h


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
RUN git fetch --all && git checkout ${ptg} -b ${ptg} || git checkout ${ptg}

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
ENV TELESCOPE=MT

WORKDIR /home/saluser/repos/slalib_source_lsst_161203
RUN source scl_source enable devtoolset-8 && make

WORKDIR /home/saluser/repos/tcspk_source_lsst_161203
RUN source scl_source enable devtoolset-8 && make

WORKDIR /home/saluser/repos/ts_pointing_common
RUN mkdir build

WORKDIR /home/saluser/repos/ts_pointing_common/build
RUN source scl_source enable devtoolset-8 && \
    source /opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux/release.com && \
    cmake -DRPM=ON .. && make && \
    cmake -DRPM=ON -DAT=ON .. && make

RUN mkdir -p $PTG_DATA_DIR && cp $LSST_TOP/src/data/* $PTG_DATA_DIR/

WORKDIR /home/saluser/
COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
