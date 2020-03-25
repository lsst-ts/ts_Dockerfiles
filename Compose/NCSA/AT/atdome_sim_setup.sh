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
echo "# Setting ATDome Simulator"

setup ts_ATDome -t current

while :
    do
        run_atdome.py -s
        echo "# ATDome Simulator exited. Restarting..."
done

