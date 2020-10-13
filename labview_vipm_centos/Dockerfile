ARG CENTOS_VERSION
FROM centos:$CENTOS_VERSION
MAINTAINER Andrew Heyer

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

# Directory for manually installed VIPM packages b/c they dont work through VIPM.       
ARG VIPM_PKGS=${LV}/${LV_PATH}  


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
           libstdc++ libstdc++.i686 libXft&& \
    yum clean all && \
    rm -rf /var/cache/yum


# Install LabVIEW 2015 Runtime & VIPM 2017 
USER root
COPY vipm-2017-linux ${LV}/vipm-2017-linux
WORKDIR  ${LV}/vipm-2017-linux/LabVIEW2015SP1RTE_Linux/
RUN ./INSTALL
RUN cp -R ${LV}/vipm-2017-linux/JKI /usr/local
ENV PATH="/usr/local/JKI/VIPM:${PATH}"


# Install the LabVIEW version based on the arguments given. Read the README for more information.
COPY ${LV_PATH} ${LV}/${LV_PATH}
WORKDIR ${LV}/${LV_PATH}
RUN yes | ./INSTALL 


# Install the VNC server, this is a trick to create the .Xvncserver file
RUN echo -e 'taco12345\ntaco12345\nn' | vncserver :10 \
    && vncserver -kill :10


# Copy over a package that is needed to be manually installed
COPY jki_rsc_toolkits_palette-1.1-1.ogp ${LV}


# Exit the container with the regular user account
SHELL ["/bin/bash", "-lc"]
WORKDIR ${HOME}


########## MANUAL STEPS ###########


# Install Caraya via VIPM
# 2) Run `vipm`
# 3) Navigate to "Tools->Options->LabVIEW" click "verify" 
# 4) In the LabVIEW window that pops up, navigate to "Tools->Options->VI Server"
# 5) Check mark the "TCP/IP" box and add the following to the "Machine Acess" list "localhost", "127.0.0.1", "*" without the quotes
# 6) in VIPM navigate to "File->Open package File(s)", navigate to "/home/appuser/LabVIEW/" and double click "jki_rsc_toolkits_palette-1.1-1.ogp" to install it
# 7) Within VIPM search for "Caraya Unit Test Framework" and install it  
