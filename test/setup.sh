#!/usr/bin/env bash

source ~/miniconda3/bin/activate
source $OSPL_HOME/release.com
source /home/saluser/.bashrc

run_test_csc.py $RUN_ARG
