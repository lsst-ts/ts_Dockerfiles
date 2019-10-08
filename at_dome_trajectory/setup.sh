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
echo "# Setting up sal, salobj and scriptqueue"

setup ts_xml -t current
setup ts_sal -t current
setup ts_salobj -t current
setup ts_scriptqueue -t current
setup ts_config_attcs -t current
setup ts_ATDomeTrajectory -t current


echo "# Starting ATDomeTrajectory CSC"
while :
    do
        run_atdometrajectory.py
        echo "# CSC exited. Restarting..."
done
