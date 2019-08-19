FROM centos:centos7
MAINTAINER Rob Bovill (trekkie2@gmail.com)
ARG USER=appuser
ARG HOME=/home/${USER}

RUN yum -y --enablerepo=extras install epel-release && \
yum -y install python36 python36-devel python36-setuptools && \
yum -y install git which mlocate wget && \
yum clean all && \
rm -rf /var/cache/yum

COPY --chown=1003:1003 python-3.7.3-.el7.centos.x86_64.rpm $HOME/
RUN ls $HOME
RUN rpm -ivh --nodeps $HOME/python-3.7.3-.el7.centos.x86_64.rpm

RUN updatedb

RUN easy_install-3.6 pip && \
python3.6 -m pip install --upgrade pip setuptools numpy && \
python3.6 -m pip install robotframework && \
python3.6 -m pip install astropy && \
python3.6 -m pip install pytest

RUN curl -s http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/x/xmlstarlet-1.6.1-1.el7.x86_64.rpm --output xmlstarlet-1.6.1-1.el7.x86_64.rpm
RUN yum -y install xmlstarlet-1.6.1-1.el7.x86_64.rpm

RUN groupadd -r -g 1003 ${USER} && \
groupadd -r -g 993 docker && \
useradd -r -u 1003 -g ${USER} -G docker -m ${USER} -d ${HOME} && \
chown ${USER}:docker ${HOME}

WORKDIR ${HOME}
RUN pwd

USER ${USER}
RUN mkdir bin && mkdir trunk && mkdir Reports
ENV ROBOTFRAMEWORK_SAL_DIR ${HOME}/trunk/robotframework_SAL
ENV TS_XML_DIR ${HOME}/trunk/ts_xml

# Apparently Docker does not support variable expansion in the ADD and COPY context.
# ... Therefore, the ownership must be hardcoded.
COPY --chown=1003:1003 Test_Vars.txt ${HOME}/bin/Test_Vars.txt
COPY --chown=1003:1003 bash_profile ${HOME}/.bash_profile
RUN echo 'source ~/.bash_profile' >> ${HOME}/.bashrc
