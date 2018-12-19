#!/bin/bash

# Script to start main GUI, ptgController in ../install directory
# then simulators.
#

cd $HOME/ts_pointing_common/build
cmake -DAT=ON ..
make
make install

dbus-uuidgen >/etc/machine-id
Xvfb :99 &

cdir=$PWD

#check environment variable $LSST_TOP is set
if [ -z ${LSST_TOP+x} ]; then
  echo "ERROR:LSST_TOP must be set."
  exit 1
fi
echo "LSST_TOP is set to '$LSST_TOP'"

if [ ! -d "$LSST_TOP" ]; then
  echo "ERROR:LSST_TOP Directory ($LSST_TOP) doesn't exit."
  exit 1
fi

if [ ! -d "$LSST_TOP/install" ]; then
  echo "ERROR:install Directory ($LSST_TOP/install) doesn't exit. Make sure make install is called."
  exit 1
fi

if [ ! -d "$LSST_TOP/install/bin" ]; then
  echo "ERROR:bin Directory ($LSST_TOP/install/bin) doesn't exit."
  exit 1
fi

echo "Starting gui in xterm terminal..."
$LSST_TOP/scripts/start_gui_AT &

sleep 10
echo "Starting ATPtgController in xterm terminal..."
$LSST_TOP/scripts/start_controller_AT &

echo "Starting weather simulator in xterm terminal..."
$LSST_TOP/scripts/start_sim_weather &
echo "Starting axes simulator in xterm terminal..."
$LSST_TOP/scripts/start_sim_ATMCS

#cd $cdir

