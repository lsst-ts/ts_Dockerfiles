#!/usr/bin/env bash

# This script will setup and build all the topics. Source this the first time you start the container.

# TODO: Check that the environment needs building. Otherwise, just setup

#source /opt/lsst/software/stack/loadLSST.bash
setup lsst_distrib
#source repos/ts_sal/setup.env

mkdir -p $SAL_WORK_DIR
mkdir -p $TS_SAL_DIR/lib

cd /home/saluser/repos/ts_xml
eups declare -r . ts_xml -t $USER

cd /home/saluser/repos/ts_sal
eups declare -r . ts_sal -t $USER
setup ts_sal -t $USER
mkdir -p $TS_SAL_DIR/lib
scons

#make_salpy_libs.py Test
make_salpy_libs.py Script
make_salpy_libs.py ScriptQueue

#cd /home/saluser/repos/ts_sal/test

#salgenerator Test validate
#salgenerator Test html
#salgenerator Test sal cpp
#salgenerator Test sal python
#salgenerator Test lib
#
#salgenerator Script validate
#salgenerator Script html
#salgenerator Script sal cpp
#salgenerator Script sal python
#salgenerator Script lib
#
#salgenerator ScriptQueue validate
#salgenerator ScriptQueue html
#salgenerator ScriptQueue sal cpp
#salgenerator ScriptQueue sal python
#salgenerator ScriptQueue lib
#
#salgenerator CBP validate
#salgenerator CBP html
#salgenerator CBP sal cpp
#salgenerator CBP sal python
#salgenerator CBP lib

#cd /home/saluser/repos/ts_salobj
#eups declare -r . ts_salobj -t $USER
#setup ts_salobj -t $USER
#scons
#
#cd /home/saluser/repos/ts_scriptqueue
#eups declare -r . ts_scriptqueue -t $USER
#setup ts_scriptqueue -t $USER
#scons

cd
