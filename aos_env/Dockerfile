# Dockerfile to execute a base machine with all set to test active optics
# system software

FROM lsstsqre/centos:7-stack-lsst_distrib-w_2019_08

LABEL author="Te-Wei Tsai <ttsai@lsst.org>"

ARG LSST_USER=lsst
ARG LSST_USER_HOME=/home/$LSST_USER
ARG LSST_DIR=/opt/lsst/software/stack
ARG SIMS_VERSION=sims_w_2019_08
ARG SHEBANGTRON_URL=https://raw.githubusercontent.com/lsst/shebangtron/master/shebangtron

USER root

# Install the required packages
RUN yum install -y csh\
    && yum clean all \
    && rm -rf /var/cache/yum

# Source the scientific pipeline automatically
RUN echo "" >> /root/.bashrc \
    && echo "# Setup the eups environment" >> /root/.bashrc \
    && echo "source $LSST_DIR/loadLSST.bash" >> /root/.bashrc

# Set the default user of container
USER $LSST_USER

# Install the lsst_sims package
RUN source $LSST_DIR/loadLSST.bash \
    && eups distrib install lsst_sims -t ${SIMS_VERSION} \
    && curl -sSL $SHEBANGTRON_URL | python

# Source the scientific pipeline automatically
RUN echo "" >> $LSST_USER_HOME/.bashrc \
    && echo "# Setup the eups environment" >> $LSST_USER_HOME/.bashrc \
    && echo "source $LSST_DIR/loadLSST.bash" >> $LSST_USER_HOME/.bashrc

# Set the default environment
SHELL ["/bin/bash", "-lc"]
WORKDIR $LSST_USER_HOME
