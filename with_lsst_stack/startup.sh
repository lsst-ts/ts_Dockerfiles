#!/bin/bash

source /opt/lsst/software/stack/loadLSST.bash
setup lsst_distrib

cd /home/lsst/repos/salobj
setup -r .
scons

cd /home/lsst/repos/
