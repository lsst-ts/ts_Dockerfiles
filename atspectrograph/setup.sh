#!/usr/bin/env bash

source ~/miniconda3/bin/activate
source $OSPL_HOME/release.com
source /home/saluser/.bashrc

echo "# Starting ATSpectrograph CSC"

atspec_csc.py $RUN_ARG

echo "# ATSpectrograph exited"
