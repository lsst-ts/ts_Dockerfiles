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

# setup ts_xml -t current
# setup ts_sal -t current
#setup ts_salobj -t $USER
#setup ts_scriptqueue -t $USER
#export PYTHONPATH=$PYTHONPATH:/opt/lsst/ts_sal/lib/
#export LD_LIBRARY_PATH=$LDLIBRARY_PATH:/opt/OpenSpliceDDS/HDE/x86_64.linux/lib
# export PYTHONPATH=$PYTHONPATH:/home/saluser/repos/ts_opensplice/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux-debug/tools/python/src/python36-site-packages/dds-6.9.190227OSS-py3.6-linux-x86_64.egg/

/bin/bash --rcfile /home/saluser/.bashrc
