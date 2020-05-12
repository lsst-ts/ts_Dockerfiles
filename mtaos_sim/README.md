# MTAOS Software Simulation Environment

This is the software environment for the MTAOS software simulator.

## Overview

This docker is based off the [lsstts/aos_aoclc](https://hub.docker.com/repository/docker/lsstts/aos_aoclc) image with everything required to run the MTAOS software. When building the container (docker build), assign `IMAGE_TAG` with --build-arg command line argument.

Container executes `run_mtaos.py -s` to run the MTAOS simulator.

Environment variable `ISRDIRPATH` is used to assign the Instrument Signature Removal (ISR). This is the disk position of butler instance basically (notice the butler instance has a hierarchy structure). This value will override the value defined in the configuration file in `ts_config_mttcs`. Environmental values can be changed with the `-e` argument to docker run command - see man docker-run for details.

## Tag List

- w_2020_16_sal
  - ts_MTAOS - master branch (commit: 8b73ca2)
  - [AOCLC packages](https://hub.docker.com/repository/docker/lsstts/aos_aoclc)
- w_2020_15_sal
  - ts_MTAOS - master branch (commit: 8b73ca2)
  - [AOCLC packages](https://hub.docker.com/repository/docker/lsstts/aos_aoclc)
- w_2020_15_sal
  - ts_MTAOS - master branch (commit: 2e23b60)
  - [AOCLC packages](https://hub.docker.com/repository/docker/lsstts/aos_aoclc)
- w_2020_06_sal
  - ts_config_mttcs - develop branch (commit: 2924779)
  - ts_MTAOS - develop branch (commit: f9de1d7)
  - [AOCLC packages](https://hub.docker.com/repository/docker/lsstts/aos_aoclc)
- v0.3
  - python - (ver: 3.7.2)
  - ts_sal - master branch (commit: ac2ca6b)
  - ts_xml - develop branch (commit: 994918f)
  - ts_opensplice - master branch (commit: dba3466) using OpenSpliceDDS v6.9.0
  - ts_config_ocs - develop branch (commit: 0da9278)
  - ts_config_mttcs - develop branch (commit: 0efe216)
  - ts_salobj - master branch (commit: 4fea586)
  - ts_MTAOS - master branch (commit: d018609)
- v0.2
  - python - (ver: 3.7.2)
  - ts_sal - master branch (commit: ac2ca6b)
  - ts_xml - master (commit: db3b535)
  - ts_opensplice - master branch (commit: dba3466) using OpenSpliceDDS v6.4.1
  - ts_config_ocs - develop branch (commit: 0da9278)
  - ts_config_mttcs - develop branch (commit: 0efe216)
  - ts_salobj - master branch (commit: 4fea586)
- v0.1
  - python - (ver: 3.6.7)
  - ts_sal - develop branch (commit: 10d2039)
  - ts_xml - develop branch (commit: e644c6b)
  - ts_opensplice - master branch (commit: d0661fb) using OpenSpliceDDS v6.4.1
  - ts_salobj - master branch (commit: abfecf2)
