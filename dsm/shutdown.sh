#!/usr/bin/env bash

source ~/miniconda3/bin/activate
source $OSPL_HOME/release.com

shutdown_dsm.py --index=${CSC_INDEX} -f
