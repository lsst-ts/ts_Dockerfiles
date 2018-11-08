#!/bin/bash

cat /home/lsst/repos/ts_sal/test/sql/*.sqldef > /home/lsst/repos/ts_sal/test/sql/efd.sqldef
mysql -h0.0.0.0 -u efduser -plssttest EFD < /home/lsst/repos/ts_sal/test/sql/efd.sqldef

cd /home/lsst/repos/ts_sal/test/ATDome/cpp/src
source /home/lsst/repos/ts_sal/setup.env
./sacpp_ATDome_event_efdwriter &
./sacpp_ATDome_command_efdwriter &
./sacpp_ATDome_telemetry_efdwriter
