#!/usr/bin/env bash

source /opt/lsst/software/stack/loadLSST.bash
source $LSST_SDK_INSTALL/setup.env

while :
    do
    
    if [ "$TELESCOPE" == "Main" ]; then
	echo "# Running main telescope pointing component..."
	/home/saluser/repos/ts_pointing_common/build/bin/MTPtgController
	echo "# Main telescope pointing component exited."
    else
	echo "# Running auxiliary telescope pointing component..."
        /home/saluser/repos/ts_pointing_common/build/bin/ATPtgController
	echo "# Auxiliary telescope pointing component exited."
    fi
done
