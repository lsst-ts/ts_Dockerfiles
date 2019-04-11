FROM centos:7 as tunable_laser_eups
ENV STACK_VERSION=16.0
ENV LSST_USER=lsst
ENV LSST_USER_HOME=/home/$LSST_USER
ENV LSST_DIR=/opt/lsst
ENV NEWINSTALL_URL=https://raw.githubusercontent.com/lsst/lsst/${STACK_VERSION}/scripts/newinstall.sh
ENV SHEBANGTRON_URL=https://raw.githubusercontent.com/lsst/shebangtron/master/shebangtron
ENV GIT_VERSION=2.19.2
ENV LSST_SDK_INSTALL=$LSST_USER_HOME/gitrepo/ts_sal
ENV OSPL_HOME=$LSST_USER_HOME/gitrepo/ts_opensplice/OpenSpliceDDS/V6.4.1/HDE/x86_64.linux
ENV PYTHON_BUILD_VERSION=3.6m
ENV PYTHON_BUILD_LOCATION=$LSST_DIR/lsst_stack/python/miniconda3-4.3.21/
ENV LSST_DDS_DOMAIN=auxtelpath
SHELL ["/bin/bash","-c"]
USER root
RUN yum -y install curl-devel expat-devel gettext-devel gcc openssl-devel zlib-devel make && yum -y install perl-ExtUtils-MakeMaker && yum -y clean all && rm -rf /var/cache/yum 
WORKDIR /usr/src
RUN curl -O https://mirrors.edge.kernel.org/pub/software/scm/git/git-${GIT_VERSION}.tar.gz && tar -xzf git-${GIT_VERSION}.tar.gz && chown -R root:root git-${GIT_VERSION}/
WORKDIR /usr/src/git-${GIT_VERSION}
RUN make prefix=/usr/local all && make prefix=/usr/local install && rm -rf /usr/src/git-${GIT_VERSION}.tar.gz /usr/src/git-${GIT_VERSION}
RUN yum -y install bison blas bzip2 bzip2-devel cmake curl flex fontconfig freetype-devel gawk gcc-c++ gcc-gfortrangettext glib2-devel java-1.8.0-openjdk libcurl-devel libuuid-devel libXext libXrender libXt-devel make mes-libGL ncurses-devel openssl-devel patch perl perl-ExtUtils-MakeMaker readline-devel sed tar which zlib-devel && yum -y install centos-release-scl && yum -y install devtoolset-6-gcc-gfortran devtoolset-6-gcc devtoolset-6-gcc-c++ && yum -y clean all && rm -rf /var/cache/yum 
RUN yum -y install ncurses-libs xterm xorg-x11-fonts-misc java-1.7.0-openjdk-devel maven python-devel swig git tk-devel && yum -y clean all && rm -rf /var/cache/yum 
RUN groupadd $LSST_USER && useradd -g $LSST_USER -m $LSST_USER -s /bin/bash
RUN echo "source $LSST_DIR/lsst_stack/loadLSST.bash" >> /root/.bashrc
RUN mkdir -p $LSST_DIR/lsst_stack
RUN chown ${LSST_USER}:${LSST_USER} $LSST_DIR/lsst_stack
USER $LSST_USER
RUN mkdir ~/gitrepo && cd ~/gitrepo && git clone https://github.com/lsst-ts/ts_xml.git && git clone https://github.com/lsst-ts/ts_opensplice && git clone --branch v3.8.41 https://github.com/lsst-ts/ts_sal && git clone --branch v3.8.0 https://github.com/lsst-ts/ts_salobj
WORKDIR $LSST_DIR/lsst_stack
RUN scl enable devtoolset-6 bash && curl -OL $NEWINSTALL_URL && bash newinstall.sh -cbtS
SHELL ["/usr/bin/scl","enable","devtoolset-6"]
RUN source loadLSST.bash && eups distrib install sconsUtils $STACK_VERSION && curl -sSL $SHEBANGTRON_URL | python && eups declare -r ~/gitrepo/ts_xml -t current ts_xml && eups declare -r ~/gitrepo/ts_sal ts_sal 3.8.41 && eups declare -r ~/gitrepo/ts_salobj ts_salobj 3.8.0 && setup sconsUtils $STACK_VERSION && setup ts_xml -t current && source ~/gitrepo/ts_sal/setup.env && setup ts_sal 3.8.41 && cd ~/gitrepo/ts_sal && mkdir -p $SAL_WORK_DIR && mkdir -p $TS_SAL_DIR/lib && cd ~/gitrepo/ts_sal && scons  && make_salpy_libs.py Test TunableLaser && cd ~/gitrepo/ts_salobj && setup -r . && scons && scons install declare
