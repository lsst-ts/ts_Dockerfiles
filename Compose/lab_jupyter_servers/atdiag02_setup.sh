#!/usr/bin/env bash

# Source this file when starting the container to set it up

echo "#"
echo "# Loading sal environment"
. repos/ts_sal/setup.env
echo "#"
echo "# Loading LSST Stack"
. /opt/lsst/software/stack/loadLSST.bash
setup lsst_distrib
echo "#"
echo "# Setting up sal, salobj and scriptqueue"

export LSST_DDS_IP=`ip route get 1 | awk '{print $(7);exit}'`

setup ts_xml -t current
setup ts_sal -t current
setup ts_salobj -t current
setup ts_scriptqueue -t current

echo "#"
echo "# Starting jupyter lab server"

while :
  do
    jupyter lab --ip `ip route get 1 | awk '{print $(7);exit}'` --port 8885
done
