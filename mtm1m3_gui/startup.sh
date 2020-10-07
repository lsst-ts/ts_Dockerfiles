#!/usr/bin/bash

if [ "$#" -eq 0 ]; then
    cd /home/saluser/
    source .setup_salobj.sh
    ./repos/ts_m1m3supportgui/M1M3GUI
fi

exec "$@"
