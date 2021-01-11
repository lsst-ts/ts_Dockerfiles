# Generic SAL configuration
FROM centos:centos7

RUN yum update -y \
  && yum install -y git gcc gcc-c++ glibc autoconf make file libtool-ltdl-devel libtool automake openssl-devel bzip2-devel libffi-devel ncurses-libs xterm xorg-x11-fonts-misc java-1.8.0-openjdk-devel maven swig tk-devel vim bash-completion bash-completion-extras wget libjpeg-turbo-devel sqlite-devel libusb-devel popt-devel gettext-devel libexif-devel LibRaw-devel \
  && yum clean all

RUN wget -q https://www.python.org/ftp/python/3.7.9/Python-3.7.9.tgz \
  && tar xzf Python-3.7.9.tgz \
  && cd Python-3.7.9 \
  && ./configure --enable-optimizations --enable-shared --with-system-expat --with-ensurepip=yes --with-system-ffi \
  && make -j4 build_all \
  && make altinstall

RUN echo "/usr/local/lib" > /etc/ld.so.conf.d/python3.conf \
  && ldconfig

RUN cd /usr/local/bin \
  && sudo ln -s python3.7 python3 \
  && sudo ln -s python3 python \
  && sudo ln -s pip3.7 pip3 \
  && sudo pip3 install --upgrade pip

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
  && pip3 install ts-salobj ts-idl \
  && pip3 install jupyterlab

# All-Sky camera specific configuration
RUN cd /tmp \
  && git clone https://github.com/gphoto/libgphoto2.git \
  && cd libgphoto2 \
  && autoreconf --install --symlink \
  && ./configure \
  && make \
  && make install \
# Copy the .pc files so pkg-config can find them later on
  && cp libgphoto2.pc /usr/share/pkgconfig \
  && cp libgphoto2_port/libgphoto2_port.pc /usr/share/pkgconfig \
  && echo "/usr/local/lib" >> /etc/ld.so.conf.d/gphoto2.conf \
  && echo "/usr/local/lib/libgphoto2/2.5.26.1" >> /etc/ld.so.conf.d/gphoto2.conf \
  && echo "/usr/local/lib/libgphoto2_port/0.12.0" >> /etc/ld.so.conf.d/gphoto2.conf \
  && ldconfig

RUN cd /tmp \
  && git clone https://github.com/gphoto/gphoto2.git \
  && cd gphoto2 \
  && autoreconf --install --symlink \
  && ./configure \
  && make \
  && make install

RUN cd /tmp \
  && git clone https://github.com/jim-easterbrook/python-gphoto2.git \
  && cd python-gphoto2 \
  && python3 setup.py build_swig \
  && python3 setup.py build \
  && python3 setup.py install

RUN pip3 install Pillow rawpy

RUN adduser -G wheel,dialout allsky

USER allsky
WORKDIR /home/allsky

RUN git clone https://github.com/lsst-ts/ts_GenericCamera.git \
  && git clone https://github.com/lsst-ts/ts_config_ocs.git \
  && git clone https://github.com/lsst-ts/ts_ddsconfig.git \
  && git clone https://github.com/lsst-ts/ts_salobj.git \
  && git clone https://github.com/lsst-ts/ts_xml.git \
  && git clone https://github.com/lsst-ts/ts_sal.git \
  && git clone https://github.com/lsst-ts/ts_idl.git \
  && git clone https://github.com/lsst-ts/ts_notebooks.git

ENV TS_CONFIG_OCS_DIR=/home/allsky/ts_config_ocs
ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/aarch64.linux
ENV OSPL_URI=file://${OSPL_HOME}/etc/config/ospl.xml
ENV OSPL_RELEASE=6.9.190925OSS
ENV PATH=${OSPL_HOME}/bin:${PATH}
ENV LD_LIBRARY_PATH=${OSPL_HOME}/lib
ENV LSST_DDS_PARTITION_PFREFIX=GenericCamera
ENV LSST_DDS_QOS=file:///home/allsky/ts_idl/qos/QoS.xml
ENV TS_SAL_ROOT=/home/allsky/ts_sal
ENV LSST_SDK_INSTALL=${TS_SAL_ROOT}
ENV SAL_HOME=${TS_SAL_ROOT}/lsstsal
ENV SAL_DIR=${TS_SAL_ROOT}/lsstsal/scripts
ENV SAL_WORK_DIR=${TS_SAL_ROOT}/test
ENV PATH=${SAL_DIR}:${PATH}
ENV TS_XML_DIR=/home/allsky/ts_xml
ENV TS_SAL_DIR=/home/allsky/ts_sal
ENV PYTHONPATH=/home/allsky/ts_GenericCamera/python:/home/allsky/ts_ddsconfig/python:/home/allsky/ts_salobj/python:/home/allsky/ts_sal/python:/home/allsky/ts_idl/python:/home/allsky/ts_xml/python
ENV PATH=/home/allsky/ts_GenericCamera/bin:/home/allsky/ts_sal/bin:${PATH}

RUN make_idl_files.py GenericCamera

ENTRYPOINT /bin/bash
