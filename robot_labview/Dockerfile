ARG CENTOS_VERSION
FROM centos:$CENTOS_VERSION
MAINTAINER Andrew Heyer

# Obtain arguments
ARG USER=appuser
ARG HOME=/home/${USER}
ARG LV_PATH

RUN yum -y update
RUN yum -y install git
RUN yum -y --enablerepo=extras install epel-release
RUN yum -y install git which mlocate wget \
openssl-devel make gcc-c++ bzip2-devel libffi-devel && \
yum clean all && \
rm -rf /var/cache/yum
#python37-devel

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

RUN groupadd -r -g 1003 ${USER} && \
groupadd -r -g 993 docker && \
useradd -r -u 1003 -g ${USER} -G docker -m ${USER} -d ${HOME} && \
chown ${USER}:docker ${HOME}

WORKDIR ${HOME}
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


# Install LabVIEW 2015 Runtime & VIPM 2017 
# ***LV2015 is a dependency for VIPM*** ***VIPM 2020 not out yet for LABVIEW 2020*** 
USER root
COPY vipm-2017-linux ${HOME}/LabVIEW/vipm-2017-linux
WORKDIR  /home/appuser/LabVIEW/vipm-2017-linux/LabVIEW2015SP1RTE_Linux/
RUN ./INSTALL
RUN cp -R /home/appuser/LabVIEW/vipm-2017-linux/JKI /usr/local

# Install LabVIEW 2018SP1
# COPY ${LV_PATH} /home/appuser/LabVIEW/LabVIEW2018
# WORKDIR /home/appuser/LabVIEW/LabVIEW2018
# RUN echo -e 'y\ny\ny\ny\ny\ny\ny\ny\ny\ny\ny\ny\ny\ny\nn\n' | ./INSTALL

# Install LabVIEW 2020
COPY ${LV_PATH} /home/appuser/LabVIEW/${LV_PATH}
WORKDIR /home/appuser/LabVIEW/${LV_PATH}
RUN echo -e 'y\ny\ny\ny\ny\ny\ny\ny\ny\ny\ny\ny\ny\ny\nn\n' | ./INSTALL
