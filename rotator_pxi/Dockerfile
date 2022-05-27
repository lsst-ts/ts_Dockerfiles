# Dockerfile to execute a base machine to test the rotator PXI code by Moog

FROM centos:centos7

LABEL author="Te-Wei Tsai <ttsai@lsst.org>"

ARG LSST_USER=lsst
ARG LSST_USER_HOME=/home/${LSST_USER}

ARG LINUX_KERNEL_VERSION=linux-3.18.25
ARG LINUX_KERNEL_FILE=${LINUX_KERNEL_VERSION}.tar.gz
ARG LINUX_KERNEL_SOURCE_DIR_HOST=libs/linuxKernel
ARG LINUX_SOURCE_DIR=/home/linuxSrcDir

ARG XENOMAI_VERSION=xenomai-3.0.1
ARG XENOMAI_FILE=${XENOMAI_VERSION}.tar.bz2
ARG XENOMAI_SOURCE_DIR_HOST=libs/xenomai
ARG XENOMAI_SOURCE_DIR=/home/xenomai
ARG XENOMAI_BUILD_DIR=/home/build

ARG IPIPE_PATCH_FILE=ipipe-core-3.18.20-x86-9.patch

ARG ETHERCAT_VERSION=ethercat-hg
ARG ETHERCAT_FILE=${ETHERCAT_VERSION}.tar.gz
ARG ETHERCAT_SOURCE_DIR_HOST=libs/ethercat
ARG ETHERCAT_SOURCE_DIR=/home/ethercat

ARG HDF5_VERSION=hdf5-1.12.0
ARG HDF5_FILE=${HDF5_VERSION}.tar.gz
ARG HDF5_SOURCE_DIR_HOST=libs/hdf5
ARG HDF5_SOURCE_DIR=/home/hdf5

ARG GOOGLETEST_VERSION=googletest-release-1.10.0
ARG GOOGLETEST_FILE=${GOOGLETEST_VERSION}.tar
ARG GOOGLETEST_SOURCE_DIR_HOST=libs/googletest
ARG GOOGLETEST_SOURCE_DIR=/home/googletest

ARG LIBYAML_VERSION=yaml-0.2.5
ARG LIBYAML_FILE=${LIBYAML_VERSION}.tar
ARG LIBYAML_SOURCE_DIR_HOST=libs/libyaml
ARG LIBYAML_SOURCE_DIR=/home/libyaml

USER root

# Install the required packages
RUN yum update -y \
    && yum clean all \
    && yum groupinstall -y "Development tools" \
    && yum install -y epel-release \
    && yum install -y ncurses-devel hmaccalc zlib-devel binutils-devel \
    elfutils-libelf-devel wget bc xfsdump nfs-utils grub2 cmake glib-devel \
    glib2-devel.x86_64 libtool autoconf automake python-devel python-pip \
    python3 clang \
    && yum clean all \
    && rm -rf /var/cache/yum

# Install the pip modules
RUN pip3 install gcovr

# Install the Linux kernel
COPY ${LINUX_KERNEL_SOURCE_DIR_HOST}/${LINUX_KERNEL_FILE} /home
RUN mkdir ${LINUX_SOURCE_DIR} \
    && cd ${LINUX_SOURCE_DIR} \
    && mv /home/${LINUX_KERNEL_FILE} . \
    && tar -xzf ${LINUX_KERNEL_FILE} \
    && cd ${LINUX_KERNEL_VERSION} \
    && make defconfig \
    && make \
    && make modules_install \
    && make install \
    && rm ../${LINUX_KERNEL_FILE}

# Install the Xenomai dual kernel
COPY ${XENOMAI_SOURCE_DIR_HOST}/${XENOMAI_FILE} /home
COPY ${XENOMAI_SOURCE_DIR_HOST}/${IPIPE_PATCH_FILE} /home
RUN mkdir ${XENOMAI_SOURCE_DIR} \
    && cd ${XENOMAI_SOURCE_DIR} \
    && mv /home/${XENOMAI_FILE} . \
    && mv /home/${IPIPE_PATCH_FILE} . \
    && tar -xf ${XENOMAI_FILE} \
    && cd ${LINUX_SOURCE_DIR}/${LINUX_KERNEL_VERSION} \
    && ${XENOMAI_SOURCE_DIR}/${XENOMAI_VERSION}/scripts/prepare-kernel.sh \
    --arch=x86_64 --ipipe=${XENOMAI_SOURCE_DIR}/${IPIPE_PATCH_FILE} \
    && rm ${XENOMAI_SOURCE_DIR}/${XENOMAI_FILE}

# Install the Xenomai libraries and tools
RUN mkdir ${XENOMAI_BUILD_DIR} \
    && cd ${XENOMAI_BUILD_DIR} \
    && ${XENOMAI_SOURCE_DIR}/${XENOMAI_VERSION}/configure \
    && make install

# Install the EtherCAT
COPY ${ETHERCAT_SOURCE_DIR_HOST}/${ETHERCAT_FILE} /home
RUN mkdir ${ETHERCAT_SOURCE_DIR} \
    && cd ${ETHERCAT_SOURCE_DIR} \
    && mv /home/${ETHERCAT_FILE} . \
    && tar -xzf ${ETHERCAT_FILE} \
    && cd ${ETHERCAT_VERSION} \
    && ./bootstrap \
    && ./configure --enable-8139too=no --enable-generic=no \
    --with-xenomai-dir=/usr/xenomai --enable-cycles \
    --with-linux-dir=${LINUX_SOURCE_DIR}/${LINUX_KERNEL_VERSION} \
    && make \
    && make modules \
    && make install \
    && make modules install \
    && rm ../${ETHERCAT_FILE}

# Install the HDF5
COPY ${HDF5_SOURCE_DIR_HOST}/${HDF5_FILE} /home
RUN mkdir ${HDF5_SOURCE_DIR} \
    && cd ${HDF5_SOURCE_DIR} \
    && mv /home/${HDF5_FILE} . \
    && tar -xzf ${HDF5_FILE} \
    && cd ${HDF5_VERSION} \
    && autoreconf --install \
    && ./configure --prefix=/usr/local/hdf5 \
    && make \
    && make install \
    && rm ../${HDF5_FILE}

# Install the google test
COPY ${GOOGLETEST_SOURCE_DIR_HOST}/${GOOGLETEST_FILE} /home
RUN mkdir ${GOOGLETEST_SOURCE_DIR} \
    && cd ${GOOGLETEST_SOURCE_DIR} \
    && mv /home/${GOOGLETEST_FILE} . \
    && tar -xvf ${GOOGLETEST_FILE} \
    && cd ${GOOGLETEST_VERSION} \
    && cmake . \
    && make \
    && make install \
    && rm ../${GOOGLETEST_FILE}

# Install the libyaml
COPY ${LIBYAML_SOURCE_DIR_HOST}/${LIBYAML_FILE} /home
RUN mkdir ${LIBYAML_SOURCE_DIR} \
    && cd ${LIBYAML_SOURCE_DIR} \
    && mv /home/${LIBYAML_FILE} . \
    && tar -xvf ${LIBYAML_FILE} \
    && cd ${LIBYAML_VERSION} \
    && ./configure \
    && make \
    && make install \
    && rm ../${LIBYAML_FILE}

# Add LSST user
RUN useradd -ms /bin/bash ${LSST_USER}

# Change to LSST user
USER ${LSST_USER}

# Set the default environment
SHELL ["/bin/bash", "-lc"]
WORKDIR ${LSST_USER_HOME}
