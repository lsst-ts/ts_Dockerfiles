FROM centos:centos7
MAINTAINER Rob Bovill (trekkie2@gmail.com)
ARG USER=appuser
ARG HOME=/home/${USER}

RUN yum -y update
RUN yum -y --enablerepo=extras install epel-release && \
yum -y install git which mlocate wget \
python36-devel openssl-devel make gcc-c++ bzip2-devel libffi-devel && \
yum clean all && \
rm -rf /var/cache/yum

ADD Python-3.7.6.tgz ${HOME}/
RUN cd ${HOME}/Python-3.7.6 && \
./configure --prefix=/usr/local && \
make && make install

RUN updatedb

RUN easy_install-3.7 pip && \
python3.7 -m pip install --upgrade pip setuptools numpy && \
python3.7 -m pip install robotframework && \
python3.7 -m pip install astropy && \
python3.7 -m pip install pytest

RUN curl -s http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/x/xmlstarlet-1.6.1-1.el7.x86_64.rpm --output xmlstarlet-1.6.1-1.el7.x86_64.rpm
RUN yum -y install xmlstarlet-1.6.1-1.el7.x86_64.rpm

RUN groupadd -g 1003 ${USER} && \
useradd -r -u 1003 -g ${USER} -m ${USER} && \
chown ${USER}:${USER} ${HOME}

WORKDIR ${HOME}
RUN pwd

USER ${USER}
RUN mkdir bin && mkdir trunk && mkdir Reports

# Apparently Docker does not support variable expansion in the ADD and COPY context.
# ... Therefore, the ownership must be hardcoded.
COPY --chown=1003:1003 Test_Vars.txt ${HOME}/bin/Test_Vars.txt
COPY --chown=1003:1003 bash_profile ${HOME}/.bash_profile
RUN echo 'source ~/.bash_profile' >> ${HOME}/.bashrc
