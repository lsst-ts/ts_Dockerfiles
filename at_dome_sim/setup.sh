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
echo "# Setting up ATDome"

setup ts_xml -t current
setup ts_sal -t current
setup ts_salobj -t current
setup ts_ATDome -t current

echo "# Starting CSC"

while :
    do
        run_atdome.py -s
        echo "# CSC exited. Restarting..."
done
