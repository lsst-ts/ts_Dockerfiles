#!/usr/bin/env bash

# Source this file when starting the container to set it up

echo "#"
echo "# Loading LSST Stack"
. /opt/lsst/software/stack/loadLSST.bash
setup lsst_distrib
echo "#"
echo "# Loading sal environment"
. ~/repos/ts_sal/setup.env
echo "#"
echo "# Setting up ts_scheduler."

setup ts_scheduler -t current

echo "#"
echo "# Running Scheduler CSC - $INDEX"

while :
    do
        run_scheduler.py $INDEX
        echo "# CSC exited, restarting..."
done
