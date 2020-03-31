echo "#"
echo "# Loading LSST Stack"
source /opt/lsst/software/stack/loadLSST.bash
setup lsst_distrib
echo "#"
echo "# Loading sal environment"
source ~/repos/ts_sal/setup.env
echo "#"
echo "# Setting up sal, salobj and scriptqueue"

setup ts_xml -t current
setup ts_sal -t current
setup ts_idl -t current
setup ts_salobj -t current
setup ts_electrometer -t current

python ~/repos/ts_electrometer2/bin/RunElectrometer.py 1
