# Dockerfile to execute a base machine with all set to test active optics
# system software

ARG IMAGE_TAG
FROM lsstsqre/centos:${IMAGE_TAG}

LABEL author="Te-Wei Tsai <ttsai@lsst.org>"

ARG SIMS_VERSION

ARG LSST_USER=lsst
ARG LSST_USER_HOME=/home/${LSST_USER}
ARG LSST_DIR=/opt/lsst/software/stack
ARG SHEBANGTRON_URL=https://raw.githubusercontent.com/lsst/shebangtron/master/shebangtron

ARG PLANTUML_URL=https://managedway.dl.sourceforge.net/project/plantuml/plantuml.jar

USER root

# Install the required packages
RUN yum install -y csh graphviz clang \
    && yum clean all \
    && rm -rf /var/cache/yum

# Source the scientific pipeline automatically
RUN echo "" >> /root/.bashrc \
    && echo "# Setup the eups environment" >> /root/.bashrc \
    && echo "source ${LSST_DIR}/loadLSST.bash" >> /root/.bashrc

# Set the default user of container
USER ${LSST_USER}

# Install the lsst_sims and needed packages
RUN source ${LSST_DIR}/loadLSST.bash \
    && eups distrib install lsst_sims -t ${SIMS_VERSION} \
    && curl -sSL ${SHEBANGTRON_URL} | python \
    && conda install -y ipython \
    && conda install -y -c conda-forge black=19.10b0

# Install the documenteer and plantUML
WORKDIR ${LSST_USER_HOME}
RUN source ${LSST_DIR}/loadLSST.bash \
    && curl -O ${PLANTUML_URL} \
    && pip install sphinxcontrib-plantuml \
    && git clone https://github.com/lsst-sqre/documenteer.git \
    && cd documenteer \
    && pip install documenteer[pipelines]

# Source the scientific pipeline automatically
RUN echo "" >> ${LSST_USER_HOME}/.bashrc \
    && echo "# Setup the eups environment" >> ${LSST_USER_HOME}/.bashrc \
    && echo "source ${LSST_DIR}/loadLSST.bash" >> ${LSST_USER_HOME}/.bashrc

# Set the default environment
SHELL ["/bin/bash", "-lc"]
WORKDIR ${LSST_USER_HOME}
