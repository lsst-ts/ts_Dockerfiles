# Dockerfile to execute a base machine with all set to test active optics system software

FROM lsstsqre/centos:7-stackbase-devtoolset-6

LABEL author="Te-Wei Tsai <ttsai@lsst.org>"

ARG LSST_DIR=/home/lsst_stack
ARG GIT_INSTALL_URL=http://opensource.wandisco.com/centos/7/git/x86_64/wandisco-git-release-7-1.noarch.rpm
ARG NEWINSTALL_URL=https://raw.githubusercontent.com/lsst/lsst/master/scripts/newinstall.sh

USER root

# Install the required packages
RUN yum install -y $GIT_INSTALL_URL \
    && yum install -y git \
    && yum clean all \
    && rm -rf /var/cache/yum

WORKDIR $LSST_DIR
SHELL ["/bin/bash", "-o", "pipefail", "-lc"]
RUN curl -sSL "$NEWINSTALL_URL" | bash -s -- -cbtS

# Install the lsst_sims and lsst_distrib packages
