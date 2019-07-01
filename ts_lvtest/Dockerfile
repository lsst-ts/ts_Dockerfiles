# Dockerfile to execute a base machine with an lv test csc

FROM centos:7.6.1810

LABEL author="Christopher Contaxis <ccontaxis@lsst.org>"

ARG LSST_USER=lsst
ARG LSST_USER_HOME=/home/$LSST_USER
ARG REPOS=$LSST_USER_HOME/repos

# Set the needed environment variables of SAL
ENV LSST_SDK_INSTALL=/opt/lsst/ts_sal
ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux
ENV PYTHON_BUILD_VERSION=3.6m
ENV PYTHON_BUILD_LOCATION=/usr/local
ENV LSST_DDS_DOMAIN=lvtest

USER root

# Install the required packages
RUN    yum update -y \
    && yum install -y git make gcc-c++ xterm xorg-x11-fonts-misc \
                      java-1.7.0-openjdk-devel maven python-devel \
                      swig tk-devel wget linuxptp \
    && yum clean all \
    && rm -rf /var/cache/yum

# Add LSST user
RUN useradd -ms /bin/bash lsst

# Install SAL runtime for Test
RUN    cd $LSST_USER_HOME \
    && mkdir SALRTE \
    && cd SALRTE \
    && wget https://project.lsst.org/ts/lsstrepo/OpenSpliceDDS-6.9.0-1.x86_64.rpm \
    && rpm -Uvh OpenSpliceDDS-6.9.0-1.x86_64.rpm \
    && wget https://project.lsst.org/ts/lsstrepo/Test-3.10.0-3.10.2.el7.x86_64.rpm \
    && rpm -Uvh Test-3.10.0-3.10.2.el7.x86_64.rpm

# Install LV2016 runtime
RUN    cd $LSST_USER_HOME \
    && mkdir LV2016RTE \
    && cd LV2016RTE \
    && wget http://download.ni.com/support/softlib/labview/labview_runtime/2016/Linux/f6/64-bit/LabVIEW2016RTE_Linux.tgz \
    && tar -xzf LabVIEW2016RTE_Linux.tgz \
    && rpm -Uvh *.rpm

# Change to LSST user
USER $LSST_USER
WORKDIR $LSST_USER_HOME

# Copy the ts_LVTest build over
USER $LSST_USER
RUN mkdir ts_LVTest
COPY ts_LVTest $LSST_USER_HOME/ts_LVTest

# Create the M1M3 Simulator startup script
USER $LSST_USER
WORKDIR $LSST_USER_HOME
RUN    echo "" >> $LSST_USER_HOME/setup.env \
    && echo "export LD_LIBRARY_PATH=/opt/lsst/ts_sal/lib:${LD_LIBRARY_PATH}" >> $LSST_USER_HOME/setup.env \
    && echo "source /opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux/release.com" >> $LSST_USER_HOME/setup.env \
    && echo "" >> $LSST_USER_HOME/startup.sh \
    && echo "source /home/lsst/setup.env" >> $LSST_USER_HOME/startup.sh \
    && echo "/opt/lsst/ts_sal/bin/SALLV_Test_Monitor &" >> $LSST_USER_HOME/startup.sh \
    && echo "/home/lsst/ts_LVTest/ts_LVTest" >> $LSST_USER_HOME/startup.sh

# Setup the environment and run the startup script
SHELL ["/bin/bash", "-lc"]
#CMD ["sh", "startup.sh"]
