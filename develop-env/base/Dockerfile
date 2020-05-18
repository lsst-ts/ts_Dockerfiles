ARG image_tag

FROM lsstsqre/centos:${image_tag}

ARG PYTHON_VERSION=3.6m
ARG CONDA_VERSION=4.5.4
ARG UID=73006
ARG GID=73006

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

USER root

# Create user and group
RUN groupadd --gid ${GID} saluser && \
    adduser -u ${UID} -m -g ${GID} -s /bin/bash saluser

RUN chown ${UID}:${GID} -R /opt/lsst/

RUN curl -sL https://rpm.nodesource.com/setup_10.x | bash - && \
    yum install -y nodejs && node --version

COPY lsst-ts-nexus.repo /tmp/lsst-ts.repo
RUN cat /tmp/lsst-ts.repo >> /etc/yum.conf

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
  tcpdump \
  graphviz* \
  yum clean all

RUN yum install -y OpenSpliceDDS-6.9.0

RUN yum install -y tzdata

WORKDIR /usr/share/zoneinfo

RUN wget http://www.ietf.org/timezones/data/leap-seconds.list

USER saluser
WORKDIR /home/saluser

RUN source /opt/lsst/software/stack/loadLSST.bash && \
    pip install jupyterlab

RUN source /opt/lsst/software/stack/loadLSST.bash && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager && \
    jupyter labextension install jupyter-matplotlib && \
    jupyter notebook --generate-config

RUN source /opt/lsst/software/stack/loadLSST.bash && \
    pip install "documenteer[pipelines]==0.4.2" "kafkit[aiohttp]" \
    aiokafka confluent_kafka asynccmd aiounittest ipdb wget pytest-subtests \
    pycodestyle aiomisc ipympl ginga pyevents jinja2 ephem gitpython \
    sqlalchemy asynctest lxml pytest-asyncio astroquery ltd-conveyor && \
    pip install moto boto3 black

RUN source /opt/lsst/software/stack/loadLSST.bash && \
    conda install -y -c conda-forge kafkacat pyqt fontconfig

ENV LSST_SDK_INSTALL=/home/saluser/repos/ts_sal
ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux
ENV LSST_DDS_DOMAIN=citest

# For Python 3.6
ENV PYTHON_BUILD_VERSION=${PYTHON_VERSION}
ENV PYTHON_BUILD_LOCATION=/opt/lsst/software/stack/python/miniconda3-${CONDA_VERSION}/

# For Python 3.7
#ENV PYTHON_BUILD_VERSION=3.7m
#ENV PYTHON_BUILD_LOCATION=/opt/lsst/software/stack/python/miniconda3-4.5.12/
