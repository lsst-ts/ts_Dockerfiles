# Generic SAL configuration
FROM centos:centos7

RUN yum install -y epel-release \
  && yum update -y \
  && yum install -y git gcc gcc-c++ make openssl-devel bzip2-devel libffi-devel ncurses-libs xterm xorg-x11-fonts-misc \
  java-1.8.0-openjdk-devel maven swig tk-devel vim bash-completion bash-completion-extras wget libgphoto2-devel \
  sqlite-devel blas-devel lapack-devel libftdi libftdi-devel \
  && yum clean all

RUN wget -q https://www.python.org/ftp/python/3.7.8/Python-3.7.8.tgz \
  && tar xzf Python-3.7.8.tgz \
  && cd Python-3.7.8 \
  && ./configure --enable-optimizations --enable-shared --with-system-expat --with-ensurepip=yes --with-system-ffi \
  && make -j4 build_all \
  && make altinstall

RUN echo "/usr/local/lib" > /etc/ld.so.conf.d/python3.conf \
  && ldconfig

RUN cd /usr/local/bin \
  && ln -s python3.7 python3 \
  && ln -s python3 python \
  && ln -s pip3.7 pip3 \
  && pip3 install --upgrade pip

RUN cd /tmp \
  && wget -q https://nodejs.org/dist/v12.18.3/node-v12.18.3-linux-arm64.tar.xz \
  && tar xJf node-v12.18.3-linux-arm64.tar.xz \
  && cd node-v12.18.3-linux-arm64 \
  && cp -R * /usr/local/

RUN wget -q https://repo-nexus.lsst.org/nexus/repository/ts_yum/releases/OpenSpliceDDS-6.9.0-1.el7.aarch64.rpm \
  && rpm -i OpenSpliceDDS-6.9.0-1.el7.aarch64.rpm \
  && export OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/aarch64.linux \
  && export PATH=${OSPL_HOME}/bin:${PATH} \
  && export LD_LIBRARY_PATH=${OSPL_HOME}/lib \
  && pip3 install cython \
  && pip3 install wheel \
  && cd /tmp \
  && wget -q https://files.pythonhosted.org/packages/21/de/edf62206777581aad3f3b7d5f7e1360955e2c1f837061ccd7eb2cf1acaed/ts-dds-6.9.190925.post7.tar.gz \
  && tar zxf ts-dds-6.9.190925.post7.tar.gz \
  && cd ts-dds-6.9.190925.post7 \
  && cp $OSPL_HOME/tools/python/code/dds* . \
  && python3 setup.py install \
  && pip3 install jupyterlab

# ESS specific configuration
RUN pip3 install astropy==4.0.1.post1 async-generator==1.10 async-timeout==3.0.1 asynctest==0.13.0 \
  imageio==2.9.0 mock==4.0.2 moto==1.3.14 numpy==1.19.1 Pillow==7.2.0 pybind11==2.2.4 pyflakes==2.1.1  \
  pylibftdi PyYAML==5.3.1 pyserial RPi.GPIO RPIO pigpio gpiozero boto3==1.14.31 botocore==1.17.32 moto==1.3.14

RUN adduser -G wheel,dialout ess
USER ess
WORKDIR /home/ess

RUN git clone https://github.com/lsst-ts/ts_ess.git \
  && git clone https://github.com/lsst-ts/ts_config_ocs.git \
  && git clone https://github.com/lsst-ts/ts_ddsconfig.git \
  && git clone https://github.com/lsst-ts/ts_salobj.git \
  && git clone https://github.com/lsst-ts/ts_xml.git \
  && git clone https://github.com/lsst-ts/ts_sal.git \
  && git clone https://github.com/lsst-ts/ts_idl.git \
  && git clone https://github.com/lsst-ts/ts_notebooks.git

ENV TS_CONFIG_OCS_DIR=/home/ess/ts_config_ocs
ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/aarch64.linux
ENV OSPL_URI=file://${OSPL_HOME}/etc/config/ospl.xml
ENV OSPL_RELEASE=6.9.190925OSS
ENV PATH=${OSPL_HOME}/bin:${PATH}
ENV LD_LIBRARY_PATH=${OSPL_HOME}/lib
ENV LSST_DDS_PARTITION_PFREFIX=ess
ENV LSST_DDS_QOS=file:///home/ess/ts_idl/qos/QoS.xml
ENV TS_SAL_ROOT=/home/ess/ts_sal
ENV LSST_SDK_INSTALL=${TS_SAL_ROOT}
ENV SAL_HOME=${TS_SAL_ROOT}/lsstsal
ENV SAL_DIR=${TS_SAL_ROOT}/lsstsal/scripts
ENV SAL_WORK_DIR=${TS_SAL_ROOT}/test
ENV PATH=${SAL_DIR}:${PATH}
ENV TS_XML_DIR=/home/ess/ts_xml
ENV TS_SAL_DIR=/home/ess/ts_sal
ENV PYTHONPATH=/home/ess/ts_ess/python:/home/ess/ts_ddsconfig/python:/home/ess/ts_salobj/python:/home/ess/ts_sal/python:/home/ess/ts_idl/python:/home/ess/ts_xml/python
ENV PATH=/home/ess/ts_ess/bin:/home/ess/ts_sal/bin:${PATH}

RUN make_idl_files.py ESS

ENTRYPOINT /bin/bash
