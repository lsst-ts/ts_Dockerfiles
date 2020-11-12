# Software Environment of AOS with SAL

This is the software environment for active optics system (AOS) to integrate with software abstraction layer (SAL).

## Overview

The development environment is installed with the SAL, `lsst_distrib`, and `lsst_sims` packages.
The beginning image of `lsstts/develop-env` has the SAL and `lsst_distrib` installed already.
The detail of lsst packages (`lsst_distrib` and `lsst_sims`) for individual tag version is listed in [Index of /stack/src/tags](https://eups.lsst.codes/stack/src/tags/).
If the `lsst_distrib` uses the weekly built tag such as `w_2020_28`, related tag of `lsst_sims` should be `sims_w_2020_28`.
Notice that there is a prefix of `sims_` for `lsst_sims` and the week (e.g. `w_2020_28`) should be the same as `lsst_distrib`.
In the build process (`docker build`), the user should assign the arguments of `IMAGE_TAG` and `SIMS_VERSION` by `--build-arg` for the tag versions of `lsstts/develop-env` and `lsst_sims`.
For the available tag of docker image of `lsstts/develop-env` to use, please follow [lsstts/develop-env](https://hub.docker.com/r/lsstts/develop-env).
This Dockerfile will be removed after AOS does not need the `lsst_sims` anymore.

## Tag List

- w_2020_42_sal
  - lsst_sims (tag: sims_w_2020_42)
  - sphinxcontrib-plantuml (by pip)
  - tcsh (by yum)
  - SAL related packages maintained by develop-env in ts_Dockerfiles
- w_2020_29_sal
  - lsst_sims (tag: sims_w_2020_29)
  - sphinxcontrib-plantuml (by pip)
  - csh (by yum)
  - SAL related packages maintained by develop-env in ts_Dockerfiles
