#!/bin/bash

source $HOME/.bash_profile
cp $HOME/trunk/ts_xml/sal_interfaces/*/*.xml $HOME/trunk/ts_sal/test
cp $HOME/trunk/ts_xml/sal_interfaces/SALSubsystems.xml $HOME/trunk/ts_sal/test
cp $HOME/trunk/ts_xml/sal_interfaces/SALGenerics.xml $HOME/trunk/ts_sal/test
cd $HOME/trunk/robotframework_salgenerator/
robot --outputdir $HOME/Reports --variable ContInt:true -e skipped --noncritical TSS* \
--variable SALVersion:3.8 --variable SALInstall:$HOME/trunk/ts_sal \
--variable OpenspliceRelease:'OpenSplice HDE Release' \
--variable OpenspliceVersion:V6.4.140320OSS --variable OpenspliceDate:2014-03-19 \
--variable PythonVersion:'Python 3.6.6' \
-A $HOME/trunk/robotframework_salgenerator/SalGen_Test.list
