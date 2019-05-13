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
echo "# Starting monochromator CSC"

setup ts_salobj -t current
setup ts_monochromator -t current

 /bin/bash --rcfile /home/saluser/.bashrc
#python /home/saluser/repos/ts_atmonochromator/bin/atmonochromator_csc.py
