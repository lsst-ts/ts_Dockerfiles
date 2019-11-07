FROM centos:7

ARG PYTHON_VERSION=3.7m
ARG CONDA_VERSION=4.5.4

ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux
ENV LSST_DDS_DOMAIN=citest
ENV PYTHON_BUILD_VERSION=${PYTHON_VERSION}
ENV PYTHON_BUILD_LOCATION=/home/saluser/miniconda3
#ENV TS_IDL_DIR=/home/saluser/repos/ts_idl/
#ENV TS_XML_VERSION=${xml_branch}

USER root

RUN adduser -u 1004 -m -s /bin/bash saluser

COPY lsst-ts.repo /tmp/lsst-ts.repo

RUN cat /tmp/lsst-ts.repo >> /etc/yum.conf && \
    yum install -y wget \
                   git \
                   make \
                   wget \
                   gcc-c++ \
                   OpenSpliceDDS-6.9.0-1

USER saluser
WORKDIR /home/saluser

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh && chmod +x miniconda.sh && ./miniconda.sh -b

RUN source ~/miniconda3/bin/activate && conda install -c lsstts python=3.7 ts-salobj="v5.0.0" cython ts-idl="1.0.0_v4.4.1"

RUN source ~/miniconda3/bin/activate && \
    source $OSPL_HOME/release.com && \
    mkdir dds && \
    cd dds && \
    tar xvzf /opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux/tools/python-support.tgz && \
    cd python/src && \
    python setup.py install

COPY setup.sh /home/saluser/.setup.sh

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup.sh"]
