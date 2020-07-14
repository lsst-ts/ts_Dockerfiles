ARG image_tag

FROM lsstsqre/centos:${image_tag}

ARG UID=1000
ARG GID=1000

LABEL maintainer Tiago Ribeiro <tribeiro@lsst.org>

ENV USER ${USER:-saluser}
ENV HOME /home/saluser

USER root

# Create user and group
RUN if [ $UID -eq 1000 ] && [ $GID -eq 1000 ]; then  \
       echo "Renaming lsst to saluser" && \
       usermod -l saluser lsst && \
       usermod -d /home/saluser -m saluser ; \
    else \
         groupadd --gid ${GID} saluser && \
         adduser -u ${UID} -m -g ${GID} -s /bin/bash saluser && \
         chown ${UID}:${GID} -R /opt/lsst/ ; \
    fi

RUN curl -sL https://rpm.nodesource.com/setup_10.x | bash - && \
    yum install -y nodejs && node --version

COPY lsst-ts-nexus.repo /etc/yum.repos.d/lsst-ts.repo

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
  libgphoto2-devel \
  yum clean all

RUN yum install -y OpenSpliceDDS-6.9.0-1.el6

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
    pip install "documenteer[pipelines]==0.5.8" "kafkit[aiohttp]" \
    aiokafka confluent_kafka asynccmd aiounittest ipdb wget pytest-subtests \
    pycodestyle aiomisc ipympl ginga pyevents jinja2 ephem gitpython \
    sqlalchemy asynctest lxml pytest-asyncio astroquery ltd-conveyor \
    moto boto3 black

RUN source /opt/lsst/software/stack/loadLSST.bash && \
    which pip > /home/saluser/pip.sh && \
    chmod a+x /home/saluser/pip.sh

USER root

RUN /home/saluser/pip.sh gphoto2

RUN source /opt/lsst/software/stack/loadLSST.bash && \
    conda install -y -c conda-forge kafkacat pyqt fontconfig

ENV LSST_SDK_INSTALL=/home/saluser/repos/ts_sal
ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux
ENV LSST_DDS_DOMAIN=citest

ENV PYTHON_BUILD_LOCATION=/opt/lsst/software/stack/python/current
