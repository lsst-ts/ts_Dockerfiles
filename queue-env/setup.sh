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

setup ts_xml -t $USER
setup ts_sal -t $USER
setup ts_salobj -t $USER
setup ts_scriptqueue -t $USER

/bin/bash --rcfile /home/saluser/.bashrc