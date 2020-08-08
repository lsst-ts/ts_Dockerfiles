# Dockerfile to execute a base machine with all set to test active optics
# system software

FROM lsstts/develop-env:c0010

LABEL author="Te-Wei Tsai <ttsai@lsst.org>"

ARG LSST_USER=saluser
ARG LSST_USER_HOME=/home/$LSST_USER
ARG LSST_DIR=/opt/lsst/software/stack
ARG SIMS_VERSION=sims_w_2020_29
ARG SHEBANGTRON_URL=https://raw.githubusercontent.com/lsst/shebangtron/master/shebangtron

USER root

# Install the required packages
RUN yum install -y csh \
    && yum clean all \
    && rm -rf /var/cache/yum

# Set the default user of container
USER $LSST_USER

# Install the lsst_sims and needed packages
RUN source $LSST_DIR/loadLSST.bash \
    && eups distrib install lsst_sims -t ${SIMS_VERSION} \
    && curl -sSL $SHEBANGTRON_URL | python

# Install the plantUML
WORKDIR $LSST_USER_HOME
RUN source $LSST_DIR/loadLSST.bash \
    && curl -O https://managedway.dl.sourceforge.net/project/plantuml/plantuml.jar \
    && pip install sphinxcontrib-plantuml

# Set the default environment
SHELL ["/bin/bash", "-lc"]
WORKDIR $LSST_USER_HOME
