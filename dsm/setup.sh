#!/usr/bin/env bash

source ~/miniconda3/bin/activate
source $OSPL_HOME/release.com

sim_flag=""
if [ ${CSC_MODE} -eq 1 ]; then
  sim_flag="-f"
elif [ ${CSC_MODE} -eq 2 ]; then
  sim_flag="-s"
fi

run_dsm.py --index=${CSC_INDEX} ${sim_flag}
