ARG CENTOS_VERSION
FROM centos:$CENTOS_VERSION

LABEL author="Andrew Heyer <aheyer@lsst.org>"

# Arguments to make Dockerfile nicer
ARG USER=appuser
ARG GROUP_ID=993
ARG USER_ID=1003

#The name of the LabVIEW folder, which contains the "./INSTALL" script
ARG LV_PATH 

# Home installation location for software.
ARG HOME=/home/${USER}

# Directory for LabVIEW and related software, keeps things tidy.          
ARG LV=${HOME}/LabVIEW

# Directory for manually installed VIPM packages b/c they dont work through
# VIPM.
ARG VIPM_PKGS=${LV}/${LV_PATH}  

USER root

# Create User and Groups
RUN groupadd -r -g ${USER_ID} ${USER} && \
    groupadd -r -g ${GROUP_ID} docker && \
    useradd -r -u ${USER_ID} -g ${USER} -G docker -m ${USER} -d ${HOME} && \
    chown ${USER}:docker ${HOME}

# Install base CentOS7 Software needed for this application
RUN yum -y update && \
    yum -y --enablerepo=extras install epel-release && \
    yum -y install git which mlocate wget tigervnc-server \
           openssl-devel make gcc-c++ bzip2-devel libffi-devel \
           libXinerama libXinerama.i686 mesa-libGL mesa-libGL.i686 \
           libstdc++ libstdc++.i686 libXft xdotool && \
    yum clean all && \
    rm -rf /var/cache/yum

# Install LabVIEW 2015 Runtime & VIPM 2017
# LabVIEW 2015 Runtime is needed by the VIPM
COPY vipm-2017-linux ${LV}/vipm-2017-linux

WORKDIR  ${LV}/vipm-2017-linux/LabVIEW2015SP1RTE_Linux/
RUN ./INSTALL
RUN cp -R ${LV}/vipm-2017-linux/JKI /usr/local

ENV PATH="/usr/local/JKI/VIPM:${PATH}"

# Install the LabVIEW version based on the arguments given. Read the README.md
# for more information.
COPY ${LV_PATH} ${LV}/${LV_PATH}
WORKDIR ${LV}/${LV_PATH}
RUN yes | ./INSTALL 

# Copy over a package that is needed to be manually installed
COPY jki_rsc_toolkits_palette-1.1-1.ogp ${LV}

# Exit the container with the regular user account and set the default entry
# point
USER ${USER}
SHELL ["/bin/bash", "-lc"]
WORKDIR ${HOME}
