#!/usr/bin/env bash

# Source this file when starting the container to set it up

echo "#"
echo "# Loading LSST Stack"
. /opt/lsst/software/stack/loadLSST.bash
setup lsst_distrib
echo "#"
echo "# Loading sal environment"
. repos/ts_sal/setup.env

export LSST_DDS_IP=`ip route get 1 | awk '{print $(7);exit}'`

echo "#"
echo "# Setting up ts_hexapod."

setup ts_hexapod -t current

echo "#"
echo "# Running hexapod CSC"

run_hexapod.py $HEXAPOD_ID
