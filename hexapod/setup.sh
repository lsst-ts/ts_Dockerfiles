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
echo "# Setting up ts_hexapod."

setup ts_hexapod -t current

# echo "#"
# echo "# Running hexapod CSC"

# while :
#     do
#         run_hexapod.py 1
#         echo "# CSC exited, restarting..."
# done
