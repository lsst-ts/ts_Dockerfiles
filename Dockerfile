# Dockerfile to execute a base machine with all set to execute the Test example of a CSC of salObj

FROM centos:7

LABEL author="Andres Anania <aanania@lsst.org>"

# install required software
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
  boost-python \
  boost-python-devel \
  maven \
  python-devel \
  python-pip \
  python-wheel \
  which \
  gnome-terminal \
  nano && \
  yum clean all
RUN yum groupinstall -y "Development Tools" "Development Libraries" && \
  yum clean all

# install python3
COPY python3-to-install.tgz .
RUN tar -zxvf python3-to-install.tgz && rm python3-to-install.tgz
RUN cd Python-3.6.3 && make install

COPY ./requirements.txt /home/docker/requirements.txt
RUN pip3 install -r /home/docker/requirements.txt

COPY ./environment.env /home/docker/environment.env
CMD chmod +x /home/docker/salgenerate.sh

WORKDIR /home/docker
RUN git clone https://github.com/lsst-ts/ts_sal.git -b develop
WORKDIR /home/docker/ts_sal 

WORKDIR /home/docker
RUN git clone https://github.com/lsst-ts/salobj.git -b develop
RUN git clone https://github.com/lsst-ts/ts_xml.git -b develop
WORKDIR /home/docker/ts_xml 
RUN git checkout 86732347cb433258fc1425551145808325794936

WORKDIR /home/docker
RUN git clone https://github.com/lsst-ts/ts_opensplice.git

ENV LSST_SDK_INSTALL=/home/docker/ts_sal
ENV OSPL_HOME=/home/docker/ts_opensplice/OpenSpliceDDS/V6.4.1/HDE/x86_64.linux
ENV PYTHON_BUILD_VERSION=3.6m
ENV PYTHON_BUILD_LOCATION=/usr/local
ENV LSST_DDS_DOMAIN=citest

CMD source /home/docker/ts_sal/setup.env

WORKDIR /home/docker/ts_sal/test
RUN cp /home/docker/ts_xml/sal_interfaces/Test/Test_* .
RUN cp /home/docker/ts_xml/sal_interfaces/SALSubsystems.xml .
COPY ./salgenerate.sh /home/docker/salgenerate.sh
RUN sh /home/docker/salgenerate.sh


# entrypoint
#ENTRYPOINT source /home/docker/ts_sal/setup.env && \
#cd /home/docker/ts_sal/test \
