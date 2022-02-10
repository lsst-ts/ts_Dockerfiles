#!/usr/bin/env bash

source /home/saluser/miniconda/bin/activate
source /home/saluser/.ospl_env.sh
export OSPL_HOME=/opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux
export OSPL_URI=file://${OSPL_HOME}/etc/config/ospl.xml
export LSST_DDS_PARTITION_PREFIX=MTDome
export PATH="${OSPL_HOME}/bin:$PATH"
export LD_LIBRARY_PATH=${OSPL_HOME}/lib:${LD_LIBRARY_PATH}
export TS_CONFIG_MTTCS_DIR=/home/saluser/ts_config_mttcs

/home/saluser/run_mtdome.py
