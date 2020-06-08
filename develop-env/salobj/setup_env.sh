#!/usr/bin/env bash

# Source this file when starting the container to set it up

source /opt/lsst/software/stack/loadLSST.bash
setup lsst_distrib
# Get Python version
# PYTHON_BUILD_VERSION=$(find ${PYTHON_BUILD_LOCATION} -name Python.h \
# 			   | xargs dirname | tr '/' ' ' | awk '{print $NF}' \
# 			   | sed 's/python//')
export PYTHON_BUILD_VERSION=3.7m
source /home/saluser/repos/ts_sal/setup.env

# Work around for setting LSST_DDS_IP working on most systems
export LSST_DDS_IP=`ip route get 1 | awk '{print $7;exit}'`
