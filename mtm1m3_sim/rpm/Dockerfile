FROM centos:centos7

ARG rpm=0:4.1.0-5.0.0.el7.x86_64
ARG m1m3=DM-24026

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

USER root

# Create user and group
RUN groupadd lsst && adduser -u 1004 -m -g lsst -s /bin/bash saluser

COPY lsst-ts.repo /tmp/lsst-ts.repo
RUN cat /tmp/lsst-ts.repo >> /etc/yum.conf

RUN yum install -y https://repo.ius.io/ius-release-el7.rpm

RUN yum -y --enablerepo=extras install epel-release \
    wget \
    git \
    make \
    wget \
    gcc-c++ \
    OpenSpliceDDS-6.9.0 \
    boost-python \
    boost-python-devel \
    cmake \
    curl-devel \
    yum clean all

RUN yum install -y MTMount-${rpm} \
    MTM1M3-${rpm}

USER saluser
WORKDIR /home/saluser/

ENV LSST_SDK_INSTALL=/opt/lsst/ts_sal/
ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux
ENV LSST_DDS_DOMAIN=citest

RUN git clone --branch ${m1m3} https://github.com/lsst-ts/ts_m1m3support

WORKDIR /home/saluser/ts_m1m3support/
RUN source ${OSPL_HOME}/release.com && \
    make SIMULATOR=1 || echo FAILED

WORKDIR /home/saluser/

COPY startup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
