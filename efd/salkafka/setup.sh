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
echo "# Setting up salkafka"

setup ts_salkafka -t current

. /home/saluser/.bashrc

# BROKER_IP=140.252.32.142
# BROKER_PORT=31090
# REGISTRY_ADDR=https://test-registry-efd.lsst.codes
# LOG_LEVEL=10
# CSC_LIST=ATCamera ATHeaderService ATArchiver ATMonochromator ATSpectrograph Electrometer Test ScriptQueue Script ATPtg ATMCS ATDome ATDomeTrajectory ATPneumatics

make_idl_files.py $CSC_LIST

run_salkafka_producer.py --broker  $BROKER_IP:$BROKER_PORT \
                         --registry  $REGISTRY_ADDR \
                         --loglevel $LOG_LEVEL \
                         --replication-factor $REPLICATION \
                         $CSC_LIST
