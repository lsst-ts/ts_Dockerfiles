#!/usr/bin/bash

if [ "$#" -eq 0 ]; then
    source /home/saluser/.setup_salobj.sh
    setup ts_salobj -t current
    ~/repos/ts_m1m3supportgui/M1M3GUI
fi

exec "$@"
