# Dockerfile to execute a base machine with all set to test active optics
# system software with the needed AOS repos

FROM lsstts/aos:w_2019_20

LABEL author="Te-Wei Tsai <ttsai@lsst.org>"

ARG LSST_USER=lsst
ARG LSST_USER_HOME=/home/$LSST_USER
ARG SIMS_VERSION=sims_w_2019_20
ARG AOS_REPOS=$LSST_USER_HOME/aos_repos

USER root

# Install the needed packages
RUN conda install -y ipython scikit-image

# Source the AOS environment automatically
RUN echo "" >> /root/.bashrc \
    && echo "# Setup the aos environment" >> /root/.bashrc \
    && echo "cd $AOS_REPOS/phosim_utils" >> /root/.bashrc \
    && echo "setup -k -r . -t $SIMS_VERSION" >> /root/.bashrc \
    && echo "cd $AOS_REPOS/ts_wep" >> /root/.bashrc \
    && echo "setup -k -r ." >> /root/.bashrc \
    && echo "cd $AOS_REPOS/ts_ofc" >> /root/.bashrc \
    && echo "setup -k -r ." >> /root/.bashrc \
    && echo "cd $AOS_REPOS/ts_phosim" >> /root/.bashrc \
    && echo "setup -k -r ." >> /root/.bashrc \
    && echo "cd $LSST_USER_HOME" >> /root/.bashrc

# Change to LSST user
USER $LSST_USER
WORKDIR $LSST_USER_HOME

# Download the needed AOS repo
RUN mkdir -p $AOS_REPOS \
    && cd $AOS_REPOS\
    && git clone -b master https://github.com/lsst-dm/phosim_utils.git \
    && cd phosim_utils/ \
    && git checkout 7b02084 \
    && cd .. \
    && git clone -b master https://github.com/lsst-ts/ts_wep.git \
    && cd ts_wep/ \
    && git checkout b0d90ce \
    && cd .. \
    && git clone -b master https://github.com/lsst-ts/ts_ofc.git \
    && cd ts_ofc/ \
    && git checkout 8b2f74b \
    && cd .. \
    && git clone -b master https://github.com/lsst-ts/ts_phosim.git \
    && cd ts_phosim/ \
    && git checkout 9078901

# Add the PhoSim and output directory
RUN mkdir -p phosim \
    && mkdir -p output

# Set the PhoSim and output environment variables
ENV PHOSIMPATH "$LSST_USER_HOME/phosim"
ENV AOCLCOUTPUTPATH "$LSST_USER_HOME/output"

# Build the packages
WORKDIR $AOS_REPOS
RUN cd phosim_utils/ \
    && setup -k -r . -t $SIMS_VERSION \
    && scons \
    && cd ../ts_wep/ \
    && setup -k -r . \
    && scons \
    && cd ../ts_ofc/ \
    && setup -k -r . \
    && scons \
    && cd ../ts_phosim/ \
    && setup -k -r . \
    && scons

# Source the AOS environment automatically
RUN echo "" >> $LSST_USER_HOME/.bashrc \
    && echo "# Setup the aos environment" >> $LSST_USER_HOME/.bashrc \
    && echo "cd $AOS_REPOS/phosim_utils" >> $LSST_USER_HOME/.bashrc \
    && echo "setup -k -r . -t $SIMS_VERSION" >> $LSST_USER_HOME/.bashrc \
    && echo "cd $AOS_REPOS/ts_wep" >> $LSST_USER_HOME/.bashrc \
    && echo "setup -k -r ." >> $LSST_USER_HOME/.bashrc \
    && echo "cd $AOS_REPOS/ts_ofc" >> $LSST_USER_HOME/.bashrc \
    && echo "setup -k -r ." >> $LSST_USER_HOME/.bashrc \
    && echo "cd $AOS_REPOS/ts_phosim" >> $LSST_USER_HOME/.bashrc \
    && echo "setup -k -r ." >> $LSST_USER_HOME/.bashrc \
    && echo "cd $LSST_USER_HOME" >> $LSST_USER_HOME/.bashrc

# Set the default environment
SHELL ["/bin/bash", "-lc"]
WORKDIR $LSST_USER_HOME
