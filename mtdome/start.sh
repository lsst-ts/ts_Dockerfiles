#!/usr/bin/env bash

screen -dmS MTDome_CSC ./mtdome_csc.sh
screen -dmS jupyterlab ./jupyterlab.sh

screen -ls
