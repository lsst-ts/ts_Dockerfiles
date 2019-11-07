# Dockerfile to execute a base machine with all set to test active optics
# system software

FROM lsstts/develop-env:sal_v4.0.0RC1_salobj_v5.0.0RC2_xml_v4.3.0RC1_idl_v0.4.0RC2

LABEL author="Te-Wei Tsai <ttsai@lsst.org>"

ARG LSST_USER=saluser
ARG LSST_USER_HOME=/home/$LSST_USER
ARG LSST_DIR=/opt/lsst/software/stack
ARG SIMS_VERSION=sims_w_2019_38
ARG SHEBANGTRON_URL=https://raw.githubusercontent.com/lsst/shebangtron/master/shebangtron

USER root

# Install the required packages
RUN yum install -y csh graphviz\
    && yum clean all \
    && rm -rf /var/cache/yum

# Set the default user of container
USER $LSST_USER

# Install the lsst_sims and needed packages
RUN source $LSST_DIR/loadLSST.bash \
    && eups distrib install lsst_sims -t ${SIMS_VERSION} \
    && curl -sSL $SHEBANGTRON_URL | python \
    && conda install -y scikit-image

# Install the plantUML
WORKDIR $LSST_USER_HOME
RUN source $LSST_DIR/loadLSST.bash \
    && wget https://newcontinuum.dl.sourceforge.net/project/plantuml/plantuml.jar \
    && pip install sphinxcontrib-plantuml

# Set the default environment
SHELL ["/bin/bash", "-lc"]
WORKDIR $LSST_USER_HOME
