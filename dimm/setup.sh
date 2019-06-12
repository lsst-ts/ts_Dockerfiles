#!/usr/bin/env bash

# Source this file when starting the container to set it up

echo "#"
echo "# Loading LSST Stack"
. /opt/lsst/software/stack/loadLSST.bash
setup lsst_distrib
echo "#"
echo "# Loading sal environment"
. repos/ts_sal/setup.env
echo "#"
echo "# Setting up sal, salobj and ataos"

setup ts_salobj -t current
setup ts_dimm -t current

echo "# Starting DIMM CSC"

while :
    do
        dimm_csc.py $CSC_INDEX
        echo "# CSC exited. Restarting..."
done

