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
echo "# Setting up ts_environment."

setup ts_environment -t current

echo "#"
echo "# Running environment CSC with index" $STATION_INDEX

while :
    do
        environment_csc.py $STATION_INDEX
        echo "# CSC exited, restarting..."
done
