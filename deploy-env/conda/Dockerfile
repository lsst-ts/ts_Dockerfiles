FROM centos:7

ARG SALOBJ_VERSION=5.15.0
ARG OPENSPLICE_VERSION=6.9.0-7
ARG DDS_VERSION=v6.9.190925_7

ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux
ENV WORKDIR=/opt/lsst/software/
ENV LSST_DDS_DOMAIN=citest

USER root

RUN adduser -u 1004 -m -s /bin/bash saluser

COPY lsst-ts.repo /etc/yum.repos.d/lsst-ts.repo
COPY setup_sal_env.sh /home/saluser/.setup_sal_env.sh
COPY setup.sh /home/saluser/.setup.sh

RUN yum install -y wget \
                   git \
                   make \
                   gcc-c++ \
                   which \
                   tcpdump \
                   OpenSpliceDDS-${OPENSPLICE_VERSION}

RUN mkdir -p ${WORKDIR} && \
    chown -R saluser:saluser /opt/lsst/ && \
    chown saluser:saluser /home/saluser/.setup.sh && \
    chown saluser:saluser /home/saluser/.setup_sal_env.sh && \
    chmod a+x /home/saluser/.setup.sh && \
    chmod a+x /home/saluser/.setup_sal_env.sh

USER saluser
WORKDIR ${WORKDIR}

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh && \
    chmod +x miniconda.sh && ./miniconda.sh -b

RUN source /home/saluser/.setup_sal_env.sh && \
    conda config --add channels conda-forge && \
    conda install -c lsstts python=3.7 ts-dds=${DDS_VERSION} ts-salobj=${SALOBJ_VERSION} cython

WORKDIR /home/saluser/

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
