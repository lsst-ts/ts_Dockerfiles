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
echo "# Setting up watcher"

setup ts_salobj -t current
setup ts_watcher -t current

echo "# Starting Watcher CSC"

while :
    do
        run_watcher.py
        echo "# Watcher exited, restarting..."
done

