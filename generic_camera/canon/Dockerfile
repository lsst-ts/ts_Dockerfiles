# Generic SAL configuration
FROM centos:centos7

RUN yum update -y && \
    yum install -y git gcc gcc-c++ glibc autoconf make file libtool-ltdl-devel libtool automake ncurses-libs swig tk-devel vim bash-completion bash-completion-extras wget libjpeg-turbo-devel libusb-devel popt-devel gettext-devel libexif-devel LibRaw-devel && \
    yum clean all

ENV WORKDIR=/opt/lsst/software/stack

RUN mkdir -p ${WORKDIR} && \
    curl -sSL https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh -o miniforge.sh && \
    chmod +x miniforge.sh && ./miniforge.sh -b -p ${WORKDIR}/miniforge && \
    source ${WORKDIR}/miniforge/bin/activate && \
    conda config --add channels conda-forge && \
    conda config --add channels lsstts && \
    conda install -y  python=3.8 && \
    conda install -y cython && \
    conda install wheel && \
    conda install conda-verify && \
    conda install -y conda-build anaconda-client setuptools_scm && \
    pip install --upgrade pip && \
    conda install -y pytest pytest-asyncio pytest-black black==19.10b0 pytest-flake8 asynctest

RUN cd /tmp && \
    wget -q https://nodejs.org/dist/v12.18.3/node-v12.18.3-linux-arm64.tar.xz && \
    tar xJf node-v12.18.3-linux-arm64.tar.xz && \
    cd node-v12.18.3-linux-arm64 && \
    cp -R * /usr/local/

RUN yum-config-manager --add-repo https://repo-nexus.lsst.org/nexus/repository/ts_yum/releases && \
    yum install -y --nogpgcheck OpenSpliceDDS && \
    export OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/aarch64.linux && \
    export PATH=${OSPL_HOME}/bin:${PATH} && \
    export LD_LIBRARY_PATH=${OSPL_HOME}/lib && \
    source ${WORKDIR}/miniforge/bin/activate && \
    conda install -y numpy=1.20 && \
    conda install -y ts-dds && \
    conda install -y ts-idl=2.3.0 && \
    conda install -y ts-salobj=6.2.2 && \
    conda install -y ts-ddsconfig && \
    conda install -y jupyterlab && \
    pip install Pillow rawpy asyncio

# Install All-Sky camera specific software
RUN cd /tmp && \
    git clone https://github.com/gphoto/libgphoto2.git && \
    cd libgphoto2 && \
    autoreconf --install --symlink && \
    ./configure && \
    make && \
    make install && \
# Copy the .pc files so pkg-config can find them later on
    cp libgphoto2.pc /usr/share/pkgconfig && \
    cp libgphoto2_port/libgphoto2_port.pc /usr/share/pkgconfig && \
    echo "/usr/local/lib" >> /etc/ld.so.conf.d/gphoto2.conf && \
    echo "/usr/local/lib/libgphoto2/2.5.26.1" >> /etc/ld.so.conf.d/gphoto2.conf && \
    echo "/usr/local/lib/libgphoto2_port/0.12.0" >> /etc/ld.so.conf.d/gphoto2.conf && \
    ldconfig

RUN cd /tmp && \
    git clone https://github.com/gphoto/gphoto2.git && \
    cd gphoto2 && \
    autoreconf --install --symlink && \
    ./configure && \
    make && \
    make install

RUN source ${WORKDIR}/miniforge/bin/activate && \
    cd /tmp && \
    git clone https://github.com/jim-easterbrook/python-gphoto2.git && \
    cd python-gphoto2 && \
    python setup.py build_swig && \
    python setup.py build && \
    python setup.py install

RUN adduser -G wheel,dialout allsky

USER allsky
WORKDIR /home/allsky

RUN source ${WORKDIR}/miniforge/bin/activate && \
    echo export LSST_DDS_QOS=file://$(python -c "from lsst.ts import idl; print(idl.get_qos_path())") >> ${HOME}/.bashrc && \
    git clone https://github.com/lsst-ts/ts_config_ocs.git

ENV TS_CONFIG_OCS_DIR=/home/allsky/ts_config_ocs
ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/aarch64.linux
ENV OSPL_URI=file://${OSPL_HOME}/etc/config/ospl.xml
ENV OSPL_RELEASE=6.9.190925OSS
ENV PATH=${OSPL_HOME}/bin:${PATH}
ENV LD_LIBRARY_PATH=${OSPL_HOME}/lib
ENV LSST_DDS_PARTITION_PREFIX=GenericCamera

ENTRYPOINT /bin/bash
