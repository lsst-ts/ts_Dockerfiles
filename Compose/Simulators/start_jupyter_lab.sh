#!/usr/bin/env bash

. repos/ts_sal/setup.env
. /opt/lsst/software/stack/loadLSST.bash
setup lsst_distrib
setup ts_xml -t current
setup ts_sal -t current
setup ts_salobj -t current
setup ts_scriptqueue -t current
setup ts_standardscripts -t current
setup ts_externalscripts -t current
jupyter lab --ip='*' --port 8886