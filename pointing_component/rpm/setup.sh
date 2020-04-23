#!/usr/bin/env bash

source $OSPL_HOME/release.com
source /home/saluser/.bashrc

if [ "$TELESCOPE" == "MT" ]
then
    echo "# Running main telescope pointing component..."
    /home/saluser/repos/ts_pointing_common/build/bin/MTPtgController
    echo "# Main telescope pointing component exited."
elif [ "$TELESCOPE" == "AT" ]
then
    echo "# Running auxiliary telescope pointing component..."
        /home/saluser/repos/ts_pointing_common/build/bin/ATPtgController
    echo "# Auxiliary telescope pointing component exited."
else
    echo "Unrecognized telescope selection ${TELESCOPE}. Must be one of MT or AT"
fi
