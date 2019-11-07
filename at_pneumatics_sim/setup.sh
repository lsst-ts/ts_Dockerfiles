#!/usr/bin/env bash

# Source this file when starting the container to set it up

echo "#"
echo "# Loading LSST Stack"
. /opt/lsst/software/stack/loadLSST.bash
setup lsst_distrib
echo "#"
echo "# Loading sal environment"
. /home/saluser/repos/ts_sal/setup.env
echo "#"
echo "# Setting up ATPneumatics Simulator"

setup ts_ATPneumaticsSimulator -t current


echo "# Starting ATPneumatics Simulator CSC"

while :
    do
        run_atpneumatics_simulator.py
        echo "# ATPneumatics Simulator exited. Restarting..."
done


