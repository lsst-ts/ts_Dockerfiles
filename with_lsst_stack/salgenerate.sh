#!/bin/sh

. /opt/lsst/software/stack/loadLSST.bash
setup lsst_distrib

. ~/repos/ts_sal/setup.env

cd ~/

cd ~/repos/ts_sal/test

cp /home/lsst/repos/ts_xml/sal_interfaces/Test/Test_* .
cp /home/lsst/repos/ts_xml/sal_interfaces/SALSubsystems.xml .

cd ~/repos/ts_sal/test
salgenerator Test validate
salgenerator Test sal cpp
salgenerator Test sal python
salgenerator Test lib

cd ~/repos/salobj
setup -r .
scons

cd ~/

