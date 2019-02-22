# Dockerfile to execute a base machine with all set to test active optics
# system software with the needed AOS repos

FROM lsstts/aos:w_2019_02

LABEL author="Te-Wei Tsai <ttsai@lsst.org>"

ARG LSST_USER=lsst
ARG LSST_USER_HOME=/home/$LSST_USER
ARG AOS_REPOS=$LSST_USER_HOME/aos_repos

USER root

# Install the needed packages
RUN conda install -y ipython scikit-image

# Source the AOS environment automatically
RUN echo "" >> /root/.bashrc \
    && echo "# Setup the aos environment" >> /root/.bashrc \
    && echo "setup sims_catUtils -t sims_w_2019_02" >> /root/.bashrc \
    && echo "cd $AOS_REPOS/obs_lsst" >> /root/.bashrc \
    && echo "setup -k -r ." >> /root/.bashrc \
    && echo "cd $AOS_REPOS/phosim_utils" >> /root/.bashrc \
    && echo "setup -k -r ." >> /root/.bashrc \
    && echo "cd $LSST_USER_HOME" >> /root/.bashrc

# Change to LSST user
USER $LSST_USER
WORKDIR $LSST_USER_HOME

# Download the needed AOS repo
RUN mkdir -p $AOS_REPOS \
    && cd $AOS_REPOS\
    && git clone -b master https://github.com/lsst/obs_lsst.git \
    && cd obs_lsst/ \
    && git checkout 69b4a98 \
    && cd .. \
    && git clone -b master https://github.com/lsst-dm/phosim_utils.git \
    && cd phosim_utils/ \
    && git checkout b8d87d9 \
    && cd .. \
    && git clone -b master https://github.com/lsst-ts/ts_tcs_wep.git \
    && cd ts_tcs_wep/ \
    && git checkout 00a021b \
    && cd .. \
    && git clone -b master https://github.com/lsst-ts/ts_tcs_wep_phosim.git \
    && cd ts_tcs_wep_phosim/ \
    && git checkout 6e4d997 \
    && cd .. \
    && git clone -b master https://github.com/lsst-ts/ts_tcs_ofcPython.git \
    && cd ts_tcs_ofcPython/ \
    && git checkout 53ee625

# Set the AOS environment variables
ENV PYTHONPATH "${PYTHONPATH}:$AOS_REPOS/ts_tcs_wep/python:$AOS_REPOS/ts_tcs_wep_phosim/python:$AOS_REPOS/ts_tcs_ofcPython/python"

# Build the packages
WORKDIR $AOS_REPOS
RUN setup sims_catUtils -t sims_w_2019_02 \
    && cd obs_lsst/ \
    && setup -k -r . \
    && scons \
    && cd .. \
    && cd phosim_utils/ \
    && setup -k -r . \
    && scons \
    && cd .. \
    && cd ts_tcs_wep/ \
    && python builder/setup.py build_ext --build-lib python/lsst/ts/wep/cwfs/lib 

# Source the AOS environment automatically
RUN echo "" >> $LSST_USER_HOME/.bashrc \
    && echo "# Setup the aos environment" >> $LSST_USER_HOME/.bashrc \
    && echo "setup sims_catUtils -t sims_w_2019_02" >> $LSST_USER_HOME/.bashrc \
    && echo "cd $AOS_REPOS/obs_lsst" >> $LSST_USER_HOME/.bashrc \
    && echo "setup -k -r ." >> $LSST_USER_HOME/.bashrc \
    && echo "cd $AOS_REPOS/phosim_utils" >> $LSST_USER_HOME/.bashrc \
    && echo "setup -k -r ." >> $LSST_USER_HOME/.bashrc \
    && echo "cd $LSST_USER_HOME" >> $LSST_USER_HOME/.bashrc

# Set the default environment
SHELL ["/bin/bash", "-lc"]
WORKDIR $LSST_USER_HOME
