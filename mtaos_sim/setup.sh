#!/usr/bin/env bash

# Source this file when starting the container to set it up

# Add the description
echo "#"
echo "# Loading LSST Stack"
. /opt/lsst/software/stack/loadLSST.bash
setup lsst_distrib
echo "#"
echo "# Loading sal environment"
. repos/ts_sal/setup.env
echo "#"
echo "# Setting up sal, salobj and scriptqueue"

# Set up the SAL related packages
setup ts_xml -t current
setup ts_sal -t current
setup ts_salobj -t current
setup ts_scriptqueue -t current
setup ts_ATDome -t current
setup ts_ATDomeTrajectory -t current
setup ts_standardscripts -t current
setup ts_externalscripts -t current

# Set up the AOS related packages
LSST_USER_HOME=/home/saluser
AOS_REPOS=${LSST_USER_HOME}/repos

cd ${AOS_REPOS}/phosim_utils/
setup -k -r .

cd ${AOS_REPOS}/ts_wep/
setup -k -r .

cd ${AOS_REPOS}/ts_ofc/
setup -k -r .

cd ${AOS_REPOS}/ts_phosim/
setup -k -r .

cd ${AOS_REPOS}/ts_config_mttcs/
setup -k -r .

cd ${AOS_REPOS}/ts_MTAOS/
setup -k -r .

# Back to the default directory
cd ${LSST_USER_HOME}
