#!/usr/bin/bash

source ${OSPL_HOME}/release.com
LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/opt/lsst/ts_sal/lib/
/home/saluser/ts_m1m3support/ts_M1M3Support -c /home/saluser/ts_m1m3support/SettingFiles
