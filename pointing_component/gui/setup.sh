#!/usr/bin/env bash

# Source this file when starting the container to set it up

echo "#"
echo "# Setting up and starting ATPtg CSC."
echo "#"

source scl_source enable devtoolset-3
source /opt/lsst/software/stack/loadLSST.bash
setup lsst_distrib
source $LSST_SDK_INSTALL/setup.env
setup ts_sal -t $USER

#/bin/bash --rcfile /home/saluser/.bashrc
python ${LSST_TOP}/src/python/gui/main.py -AT
