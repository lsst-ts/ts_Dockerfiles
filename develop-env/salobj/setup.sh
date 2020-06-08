#!/usr/bin/env bash

source ~/.setup_salobj.sh

setup ts_config_atcalsys -t current
setup ts_config_attcs -t current
setup ts_config_eas -t current
setup ts_config_latiss -t current
setup ts_config_mtcalsys -t current
setup ts_config_mttcs -t current
setup ts_config_ocs -t current
setup ts_idl -t current
setup ts_sal -t current
setup ts_salobj -t current
setup ts_xml -t current

/bin/bash --rcfile /home/saluser/.bashrc
