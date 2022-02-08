# Generic SAL configuration
FROM centos:centos7

# COPY libopenssl1_1-1.1.1d-11.20.1.aarch64.rpm /tmp
# COPY OpenSpliceDDS-6.10.4-17.el7.aarch64.rpm /tmp

RUN yum install -y epel-release && \
    yum update -y && \
    yum install -y git gcc gcc-c++ glibc autoconf make file libtool-ltdl-devel libtool automake ncurses-libs \
      swig tk-devel vim bash-completion bash-completion-extras wget libjpeg-turbo-devel libusb-devel \
      popt-devel gettext-devel libexif-devel LibRaw-devel bzip2 && \
#     rpm -i --nodeps /tmp/libopenssl1_1-1.1.1d-11.20.1.aarch64.rpm && \
#     rpm -i --nodeps /tmp/OpenSpliceDDS-6.10.4-17.el7.aarch64.rpm && \
    yum-config-manager --add-repo https://repo-nexus.lsst.org/nexus/repository/ts_yum/releases && \
    yum install -y --nogpgcheck OpenSpliceDDS-6.9.0-16.el7 && \
    yum clean all

RUN adduser -G wheel,dialout saluser
ENV CONDA_DIR=/home/saluser
ENV GPHOTO_VER=2.5.27

# Install All-Sky camera specific software
RUN cd /tmp && \
    curl -sSL https://github.com/gphoto/libgphoto2/releases/download/v${GPHOTO_VER}/libgphoto2-${GPHOTO_VER}.tar.bz2 -o libgphoto2-${GPHOTO_VER}.tar.bz2 && \
    tar jxf libgphoto2-${GPHOTO_VER}.tar.bz2 && \
    cd libgphoto2-${GPHOTO_VER} && \
    autoreconf --install --symlink && \
    ./configure && \
    make && \
    make install && \
# Copy the .pc files so pkg-config can find them later on
    cp libgphoto2.pc /usr/share/pkgconfig && \
    cp libgphoto2_port/libgphoto2_port.pc /usr/share/pkgconfig && \
    echo "/usr/local/lib" >> /etc/ld.so.conf.d/gphoto2.conf && \
    echo "/usr/local/lib/libgphoto2/${GPHOTO_VER}" >> /etc/ld.so.conf.d/gphoto2.conf && \
    echo "/usr/local/lib/libgphoto2_port/0.12.0" >> /etc/ld.so.conf.d/gphoto2.conf && \
    ldconfig

RUN cd /tmp && \
    curl -sSL https://github.com/gphoto/gphoto2/releases/download/v${GPHOTO_VER}/gphoto2-${GPHOTO_VER}.tar.bz2 -o gphoto2-${GPHOTO_VER}.tar.bz2 && \
    tar jxf gphoto2-${GPHOTO_VER}.tar.bz2 && \
    cd gphoto2-${GPHOTO_VER} && \
    autoreconf --install --symlink && \
    ./configure && \
    make && \
    make install

USER saluser
WORKDIR /home/saluser
# ENV ARCH=aarch64
ENV ARCH=x86_64

RUN mkdir -p ${CONDA_DIR} && \
    curl -sSL https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-${ARCH}.sh -o miniforge.sh && \
    chmod +x miniforge.sh && ./miniforge.sh -b -p ${CONDA_DIR}/miniforge && \
    source ${CONDA_DIR}/miniforge/bin/activate && \
    conda config --add channels lsstts && \
    conda install -y python=3.8 && \
    conda install -y cython && \
    conda install wheel && \
    conda install conda-verify && \
    conda install -y conda-build anaconda-client setuptools_scm && \
    pip install --upgrade pip && \
    conda install -y pytest pytest-asyncio pytest-black black==19.10b0 pytest-flake8 asynctest

RUN source ${CONDA_DIR}/miniforge/bin/activate && \
    conda install -y numpy=1.20 && \
    conda install -y ts-ddsconfig=0.5.2 && \
    conda install -y ts-idl=3.1.2_9.0.0_5.1.1 && \
    conda install -y ts-salobj=6.3.4 && \
    pip install Pillow rawpy asyncio && \
    cd /tmp && \
    git clone https://github.com/jim-easterbrook/python-gphoto2.git && \
    cd python-gphoto2 && \
    python setup.py build_swig && \
    python setup.py build && \
    python setup.py install

ENV TS_CONFIG_OCS_DIR=/home/saluser/ts_config_ocs
ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.6.9/HDE/aarch64.linux
ENV PATH=${OSPL_HOME}/bin:${PATH}
ENV LD_LIBRARY_PATH=${OSPL_HOME}/lib
ENV LSST_DDS_PARTITION_PREFIX=summit

RUN source ${CONDA_DIR}/miniforge/bin/activate && \
    echo export LSST_DDS_QOS=file://$(python -c "from lsst.ts import ddsconfig; print(ddsconfig.get_qos_path())") >> /home/saluser/.bashrc && \
    echo export OSPL_URI=$(python -c "from lsst.ts import ddsconfig; print( (ddsconfig.get_config_dir() / 'ospl-sp-debug.xml').as_uri())") >> /home/saluser/.bashrc && \
    git clone https://github.com/lsst-ts/ts_config_ocs.git && \
    echo source ${CONDA_DIR}/miniforge/bin/activate >> /home/saluser/.bashrc

ENTRYPOINT /bin/bash
