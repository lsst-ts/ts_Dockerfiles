#!/bin/bash

source /opt/lsst/software/stack/loadLSST.bash
setup lsst_distrib

cd /home/docker/repos/salobj
setup salobj git
scons

cd /home/opsim
