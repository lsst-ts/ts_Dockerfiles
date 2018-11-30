# Dockerfile to execute a base machine with all set to test active optics system software

FROM lsstsqre/centos:7-stackbase-devtoolset-6

LABEL author="Te-Wei Tsai <ttsai@lsst.org>"

ARG LSST_USER=lsst
ARG LSST_USER_HOME=/home/$LSST_USER
ARG LSST_DIR=/opt/lsst
ARG GIT_INSTALL_URL=http://opensource.wandisco.com/centos/7/git/x86_64/wandisco-git-release-7-1.noarch.rpm
# ARG NEWINSTALL_URL=https://raw.githubusercontent.com/lsst/lsst/master/scripts/newinstall.sh
ARG NEWINSTALL_URL=https://raw.githubusercontent.com/lsst/lsst/16.0/scripts/newinstall.sh
ARG SHEBANGTRON_URL=https://raw.githubusercontent.com/lsst/shebangtron/master/shebangtron

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

# Install the lsst_sims and lsst_distrib packages
RUN source $LSST_DIR/loadLSST.bash \
    && eups distrib install lsst_sims -t sims \
    && eups distrib install lsst_distrib -t sims \
    && curl -sSL $SHEBANGTRON_URL | python

# Source the scientific pipeline automatically
RUN echo "" >> $LSST_USER_HOME/.bashrc \
    && echo "# Setup the eups environment" >> $LSST_USER_HOME/.bashrc \
    && echo "source $LSST_DIR/loadLSST.bash" >> $LSST_USER_HOME/.bashrc

# Set the default environment
SHELL ["/bin/bash", "-lc"]
WORKDIR $LSST_USER_HOME
