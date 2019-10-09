ARG image_tag

FROM lsstsqre/centos:${image_tag}

ARG PYTHON_VERSION=3.6m
ARG CONDA_VERSION=4.5.4

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

USER root

# Create user and group
RUN adduser -u 1004 -m -g lsst -s /bin/bash saluser

RUN chmod g+w -R /opt/lsst/

COPY lsst-ts.repo /tmp/lsst-ts.repo
RUN cat /tmp/lsst-ts.repo >> /etc/yum.conf

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

RUN yum install -y OpenSpliceDDS-6.9.0-1

RUN yum install -y tzdata

WORKDIR /usr/share/zoneinfo

RUN wget http://www.ietf.org/timezones/data/leap-seconds.list

USER saluser
WORKDIR /home/saluser

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib &&\
    conda install -y -c anaconda jsonschema=3.0.1

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib && \
    conda install -y ipython jupyter jupyterlab tornado=4.5.3

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib &&\
    conda install -y jinja2 ephem gitpython
# jsonschema=3.0.1

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib &&\
    conda update -y -n base -c defaults conda && \
    conda update -y pyqt fontconfig sqlalchemy && \
    conda install -y -c anaconda-platform asynctest && \
    conda install -y -c conda-forge pytest-asyncio && \
    conda install -y -c conda-forge kafkacat moto boto3 && \
    conda install -y conda-build &&\
    conda install -y -c conda-forge pytest-flake8 && \
    conda clean -ay && \
    pip install "documenteer[pipelines]==0.4.2" && \
    pip install "kafkit[aiohttp]" && \
    pip install aiokafka && \
    pip install confluent_kafka && \
    pip install asynccmd && \
    pip install aiounittest && \
    pip install ipdb && \
    pip install wget

RUN source /opt/lsst/software/stack/loadLSST.bash && pip install --upgrade pycodestyle

ENV LSST_SDK_INSTALL=/home/saluser/repos/ts_sal
ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux
ENV LSST_DDS_DOMAIN=citest

# For Python 3.6
ENV PYTHON_BUILD_VERSION=${PYTHON_VERSION}
ENV PYTHON_BUILD_LOCATION=/opt/lsst/software/stack/python/miniconda3-${CONDA_VERSION}/

# For Python 3.7
#ENV PYTHON_BUILD_VERSION=3.7m
#ENV PYTHON_BUILD_LOCATION=/opt/lsst/software/stack/python/miniconda3-4.5.12/
