#!/usr/bin/env bash

# This script will setup and build all the topics. Source this the first time you start the container.

# TODO: Check that the environment needs building. Otherwise, just setup

. /opt/lsst/software/stack/loadLSST.bash
setup lsst_distrib
. repos/ts_sal/setup.env

cd /home/saluser/repos/ts_sal/test

salgenerator Test validate
salgenerator Test sal cpp
salgenerator Test sal python
salgenerator Test lib

salgenerator Script validate
salgenerator Script sal cpp
salgenerator Script sal python
salgenerator Script lib

salgenerator ScriptQueue validate
salgenerator ScriptQueue sal cpp
salgenerator ScriptQueue sal python
salgenerator ScriptQueue lib

salgenerator CBP validate
salgenerator CBP sal cpp
salgenerator CBP sal python
salgenerator CBP lib

cd /home/saluser/repos/salobj
eups declare -r . ts_salobj -t $USER
setup ts_salobj -t $USER
scons

cd /home/saluser/repos/ts_scriptqueue
eups declare -r . ts_scriptqueue -t $USER
setup ts_scriptqueue -t $USER
scons

cd
