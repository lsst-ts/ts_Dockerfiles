FROM almalinux:latest
MAINTAINER Rob Bovill (trekkie2@gmail.com)
ARG USER=saluser
ARG HOME=/home/${USER}

USER root

ENV PYTHONPATH="$PYTHONPATH:/usr/local/lib/python3.8/site-packages/lsst_efd_client"
RUN groupadd -r -g 1003 ${USER} && \
groupadd -r -g 993 docker && \
useradd -r -u 1003 -g ${USER} -G docker -m ${USER} -d ${HOME} && \
chown ${USER}:docker ${HOME}

RUN dnf -y update
RUN dnf -y groupinstall "Development Tools"
RUN dnf -y install wget

RUN dnf -y --enablerepo=extras install epel-release && \
dnf -y install git which mlocate \
python38-devel openssl-devel make gcc-c++ bzip2-devel libffi-devel && \
dnf clean all && \
rm -rf /var/cache/dnf

RUN updatedb

RUN python3 -m pip install -U pip && \
pip install -U setuptools numpy pytest requests && \
pip install -U robotframework && \
pip install -U lsst-efd-client

USER ${USER}
WORKDIR ${HOME}

RUN mkdir bin && mkdir repos && mkdir Reports
ENV PATH $PATH:${HOME}/bin:${HOME}/.local/bin
