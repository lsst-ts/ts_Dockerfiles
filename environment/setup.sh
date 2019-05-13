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

setup ts_salobj -t $USER
setup ts_environment -t $USER

echo "#"
echo "# Running environment CSC with index" $STATION_INDEX

python /home/saluser/repos/ts_environment/bin.src/environment_csc.py $STATION_INDEX
