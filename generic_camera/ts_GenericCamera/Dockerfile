# Based on ts_cycle_build/build/develop-env/Dockerfile
FROM lsstts/develop-env:develop

USER root

RUN yum install -y epel-release && \
    yum install -y gcc \
    gcc-c++ \
    glibc \
    autoconf \
    make \
    libtool-ltdl-devel \
    libtool \
    automake \
    libusb-devel \
    popt-devel \
    gettext-devel \
    libexif-devel \
    LibRaw-devel \
    bzip2 && \
    yum clean all

ENV gphoto2=2.5.27

# Install GPhoto2
RUN cd /tmp && \
    curl -sSL https://github.com/gphoto/libgphoto2/releases/download/v${gphoto2}/libgphoto2-${gphoto2}.tar.bz2 -o libgphoto2-${gphoto2}.tar.bz2 && \
    tar jxf libgphoto2-${gphoto2}.tar.bz2 && \
    cd libgphoto2-${gphoto2} && \
    autoreconf --install --symlink && \
    ./configure && \
    make && \
    make install && \
# Copy the .pc files so pkg-config can find them later on
    cp libgphoto2.pc /usr/share/pkgconfig && \
    cp libgphoto2_port/libgphoto2_port.pc /usr/share/pkgconfig && \
    echo "/usr/local/lib" >> /etc/ld.so.conf.d/gphoto2.conf && \
    echo "/usr/local/lib/libgphoto2/${gphoto2}" >> /etc/ld.so.conf.d/gphoto2.conf && \
    echo "/usr/local/lib/libgphoto2_port/0.12.0" >> /etc/ld.so.conf.d/gphoto2.conf && \
    ldconfig

# Install LibGPhoto2
RUN cd /tmp && \
    curl -sSL https://github.com/gphoto/gphoto2/releases/download/v${gphoto2}/gphoto2-${gphoto2}.tar.bz2 -o gphoto2-${gphoto2}.tar.bz2 && \
    tar jxf gphoto2-${gphoto2}.tar.bz2 && \
    cd gphoto2-${gphoto2} && \
    autoreconf --install --symlink && \
    ./configure && \
    make && \
    make install

ENV LDFLAGS="-L/usr/local/lib -L/usr/local/lib/libgphoto2/${gphoto2} -L/usr/local/lib/libgphoto2_port/0.12.0"

USER saluser
WORKDIR /home/saluser

RUN source /home/saluser/.setup_salobj.sh && \
    pip install Pillow rawpy asyncio && \
    cd /tmp && \
    git clone https://github.com/jim-easterbrook/python-gphoto2.git && \
    cd python-gphoto2 && \
    python setup.py build_swig && \
    python setup.py build && \
    python setup.py install

ENTRYPOINT ["/bin/bash", "--"]
CMD ["/home/saluser/.setup_dev.sh"]
