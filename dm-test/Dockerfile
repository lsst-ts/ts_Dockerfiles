# Dockerfile to execute a base machine with all set to execute the Test example of a CSC of salObj

FROM centos:7

LABEL author="Andres Anania <aanania@lsst.org>"

USER root

# install required software
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
  boost-python \
  boost-python-devel \
  maven \
  python-devel \
  python-pip \
  python-wheel \
  which \
  gnome-terminal \
  python36-devel \
  python36-setuptools \
  nano && \
  yum clean all
RUN yum groupinstall -y "Development Tools" "Development Libraries" && \
  yum clean all


RUN ln -s /usr/include/python3.6m/ /usr/local/include/python3.6m

RUN easy_install-3.6 pip
COPY ./requirements.txt /home/lsst/requirements.txt
RUN pip3 install -r /home/lsst/requirements.txt

RUN useradd -ms /bin/bash lsst
RUN chown -R lsst /home/lsst/
USER lsst

#Pulling required repositories from Github
WORKDIR /home/lsst/
RUN mkdir repos
WORKDIR /home/lsst/repos

RUN git clone https://github.com/lsst-ts/ts_sal.git -b "v3.8.13"
RUN git clone https://github.com/lsst-ts/salobj.git -b develop
RUN git clone https://github.com/lsst-ts/ts_opensplice.git
RUN git clone https://github.com/lsst-ts/ts_xml.git -b develop
WORKDIR /home/lsst/repos/ts_xml 

#Setup sal and generate basics
ENV LSST_SDK_INSTALL=/home/lsst/repos/ts_sal
ENV OSPL_HOME=/home/lsst/repos/ts_opensplice/OpenSpliceDDS/V6.4.1/HDE/x86_64.linux
ENV PYTHON_BUILD_VERSION=3.6m
ENV PYTHON_BUILD_LOCATION=/usr/local
ENV LSST_DDS_DOMAIN=citest

CMD source /home/lsst/repos/ts_sal/setup.env

WORKDIR /home/lsst/repos/ts_sal/test
RUN cp /home/lsst/repos/ts_xml/sal_interfaces/Test/Test_* .
RUN cp /home/lsst/repos/ts_xml/sal_interfaces/Test/ATDome_* .
RUN cp /home/lsst/repos/ts_xml/sal_interfaces/SALSubsystems.xml .

WORKDIR /home/lsst/

ADD --chown=lsst:lsst ./testCSC.py /home/lsst/testCSC.py
ADD --chown=lsst:lsst ./environment.env /home/lsst/environment.env
ADD --chown=lsst:lsst ./salgenerate.sh /home/lsst/salgenerate.sh
RUN chmod u+x /home/lsst/environment.env
RUN chmod u+x /home/lsst/salgenerate.sh
RUN sh /home/lsst/salgenerate.sh

# entrypoint
#ENTRYPOINT source /home/lsst/repos/ts_sal/setup.env && \
#cd /home/lsst//reposts_sal/test 
#ENTRYPOINT ["/bin/bash", "--"]
#CMD ["/home/lsst/repos/startup.sh"]
