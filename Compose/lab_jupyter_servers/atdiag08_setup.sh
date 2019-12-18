#!/usr/bin/env bash

# Source this file when starting the container to set it up

echo "#"
echo "# Loading sal environment"
. .bashrc
. repos/ts_sal/setup.env
echo "#"
echo "# Loading LSST Stack"
. /opt/lsst/software/stack/loadLSST.bash
setup lsst_distrib
echo "#"
echo "# Setting up sal, salobj and scriptqueue"

setup ts_xml -t current
setup ts_sal -t current
setup ts_salobj -t current
setup ts_scriptqueue -t current

cd ~/develop/ts_standardscripts/
eups declare -r . -t $USER
setup ts_standardscripts -t $USER

cd ~/develop/ts_externalscripts/
eups declare -r . -t $USER
setup ts_externalscripts -t $USER

cd ~/develop/cwfs

eups declare -r . -t $USER

setup cwfs -t $USER

cd ~/

echo "#"
echo "# Starting jupyter lab server"

while :
    do
        jupyter lab --ip 10.0.100.225 --port 8885
done


