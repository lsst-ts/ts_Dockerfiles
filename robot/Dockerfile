FROM centos:centos7
MAINTAINER Rob Bovill (trekkie2@gmail.com)
ARG USER=appuser
ARG HOME=/home/${USER}

USER root

RUN groupadd -r -g 1003 ${USER} && \
groupadd -r -g 993 docker && \
useradd -r -u 1003 -g ${USER} -G docker -m ${USER} -d ${HOME} && \
chown ${USER}:docker ${HOME}

RUN yum -y update
RUN yum -y groupinstall "Development Tools"
RUN yum -y install wget

RUN cd /tmp && wget https://packages.endpointdev.com/endpoint-rpmsign-7.pub && \
rpm --import endpoint-rpmsign-7.pub && rpm -qi gpg-pubkey-703df089 | gpg --with-fingerprint
RUN yum -y install https://packages.endpointdev.com/rhel/7/os/x86_64/endpoint-repo.x86_64.rpm

RUN yum -y --enablerepo=extras install epel-release && \
yum -y install git which mlocate \
python38-devel openssl-devel make gcc-c++ bzip2-devel libffi-devel && \
yum clean all && \
rm -rf /var/cache/yum

RUN updatedb

RUN cd /tmp && \
wget https://www.python.org/ftp/python/3.8.8/Python-3.8.8.tgz && \
tar xvf Python-3.8.8.tgz

RUN cd /tmp/Python-3.8.8 && \
./configure --enable-optimizations && \
make altinstall && \
ln /usr/local/bin/python3.8 /usr/local/bin/python3 && \
python3 --version && pip3.8 --version

RUN python3.8 -m pip install --upgrade pip setuptools numpy && \
python3.8 -m pip install robotframework && \
python3.8 -m pip install astropy && \
python3.8 -m pip install pytest

RUN curl -s http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/x/xmlstarlet-1.6.1-1.el7.x86_64.rpm --output xmlstarlet-1.6.1-1.el7.x86_64.rpm
RUN yum -y install xmlstarlet-1.6.1-1.el7.x86_64.rpm

WORKDIR ${HOME}
RUN pwd

USER ${USER}
RUN mkdir bin && mkdir trunk && mkdir Reports
ENV PATH $PATH:${HOME}/bin:${HOME}/.local/bin
ENV ROBOTFRAMEWORK_SAL_DIR ${HOME}/trunk/robotframework_SAL
ENV TS_XML_DIR ${HOME}/trunk/ts_xml

# Apparently Docker does not support variable expansion in the ADD and COPY context.
# ... Therefore, the ownership must be hardcoded.
COPY --chown=1003:1003 Test_Vars.txt ${HOME}/bin/Test_Vars.txt
COPY --chown=1003:1003 bash_profile ${HOME}/.bash_profile
RUN echo 'source ~/.bash_profile' >> ${HOME}/.bashrc
