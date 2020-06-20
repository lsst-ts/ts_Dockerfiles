# Software Environment of AOS Closed-Loop Simulation

This is the software environment for active optics system (AOS) to do the closed-loop simulation.

## Overview

The scientific pipeline is installed with the lsst_distrib and lsst_sims packages. The modules of phosim_utils, ts_wep, ts_ofc, and ts_phosim are in the **/home/saluser/repos** directory. In the build process, the user needs to assign the argument of `IMAGE_TAG` by `--build-arg`.

## Tag List

- w_2020_16_sal
  - phosim_utils - master branch (commit: 8744592)
  - ts_wep - master branch (commit: 1ede81e)
  - ts_ofc - master branch (commit: c5aade4)
  - ts_phosim - master branch (commit: d613cb2)
  - [LSST and SAL packages](https://cloud.docker.com/u/lsstts/repository/docker/lsstts/aos_sal)
- w_2020_15_sal
  - phosim_utils - master branch (commit: 8744592)
  - ts_wep - master branch (commit: 3c661a4)
  - ts_ofc - master branch (commit: 87075e2)
  - ts_phosim - master branch (commit: 474d2eb)
  - [LSST and SAL packages](https://cloud.docker.com/u/lsstts/repository/docker/lsstts/aos_sal)
- w_2020_14_sal
  - phosim_utils - master branch (commit: 8744592)
  - ts_wep - master branch (commit: 3c661a4)
  - ts_ofc - master branch (commit: 87075e2)
  - ts_phosim - master branch (commit: 474d2eb)
  - [LSST and SAL packages](https://cloud.docker.com/u/lsstts/repository/docker/lsstts/aos_sal)
- w_2020_06_sal
  - phosim_utils - master branch (commit: 8744592)
  - ts_wep - feature/updateApi branch (commit: 18c2303)
  - ts_ofc - master branch (commit: 558517c)
  - ts_phosim - master branch (commit: bea66c0)
  - [LSST and SAL packages](https://cloud.docker.com/u/lsstts/repository/docker/lsstts/aos_sal)
- w_2019_38_sal
  - phosim_utils - master branch (commit: c1f2391)
  - ts_wep - master branch (commit: 5d20039)
  - ts_ofc - master branch (commit: e38c4e1)
  - ts_phosim - master branch (commit: a2a42f3)
  - [LSST and SAL packages](https://cloud.docker.com/u/lsstts/repository/docker/lsstts/aos)
- w_2019_38
  - lsst_distrib (tag: w_2019_38)
  - lsst_sims (tag: sims_w_2019_38)
  - phosim_utils - master branch (commit: c1f2391)
  - ts_wep - develop branch (commit: 5d20039)
  - ts_ofc - develop branch (commit: e38c4e1)
  - ts_phosim - develop branch (commit: a2a42f3)
- w_2019_24
  - lsst_distrib (tag: w_2019_24)
  - lsst_sims (tag: sims_w_2019_24)
  - phosim_utils - master branch (commit: c1f2391)
  - ts_wep - develop branch (commit: 082fdd7)
  - ts_ofc - develop branch (commit: ccf971c)
  - ts_phosim - develop branch (commit: 774614c)
