# Dockerfile to execute a base machine with all set to test active optics system software

FROM lsstsqre/centos:7-stackbase-devtoolset-6

LABEL author="Te-Wei Tsai <ttsai@lsst.org>"

ARG LSST_USER=lsst
ARG LSST_USER_HOME=/home/$LSST_USER
ARG LSST_DIR=/opt/lsst
ARG GIT_INSTALL_URL=http://opensource.wandisco.com/centos/7/git/x86_64/wandisco-git-release-7-1.noarch.rpm
ARG NEWINSTALL_URL=https://raw.githubusercontent.com/lsst/lsst/master/scripts/newinstall.sh

USER root

# Install the required packages
RUN yum install -y $GIT_INSTALL_URL \
    && yum install -y git \
    && yum clean all \
    && rm -rf /var/cache/yum

# Add the new user
RUN mkdir -p $LSST_DIR \
	&& groupadd $LSST_USER \
	&& useradd -g $LSST_USER -m $LSST_USER \
	&& chown ${LSST_USER}:${LSST_USER} $LSST_DIR

# Set the default user of container
USER $LSST_USER

# Install the scientific pipeline
WORKDIR $LSST_DIR
SHELL ["/bin/bash", "-o", "pipefail", "-lc"]
RUN curl -sSL $NEWINSTALL_URL | bash -s -- -cbtS

# Set the default environment
SHELL ["/bin/bash", "-lc"]
WORKDIR $LSST_USER_HOME

# Install the lsst_sims and lsst_distrib packages
