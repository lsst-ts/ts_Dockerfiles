# Software Environment of AOS

This is the software environment of active optics system (AOS) with the scientific pipeline.

## Overview

The scientific pipeline is installed with the `lsst_distrib` and `lsst_sims` packages.
The detail of lsst packages (`lsst_distrib` and `lsst_sims`) for individual tag version is listed in [Index of /stack/src/tags](https://eups.lsst.codes/stack/src/tags/).
If the `lsst_distrib` uses the weekly built tag such as `w_2020_28`, related tag of `lsst_sims` should be `sims_w_2020_28`.
Notice that there is a prefix of `sims_` for `lsst_sims` and the week (e.g. `w_2020_28`) should be the same as `lsst_distrib`.
In the build process (`docker build`), the user should assign the arguments of `IMAGE_TAG` and `SIMS_VERSION` by `--build-arg` for the tag versions of `lsst_distrib` and `lsst_sims`.
For the available tag of docker image of `lsst_distrib` to use, please follow [lsstsqre/centos](https://hub.docker.com/r/lsstsqre/centos).

## Tag List

- w_2020_36
  - lsst_distrib (tag: w_2020_36)
  - lsst_sims (tag: sims_w_2020_36)
  - csh
  - graphviz
  - clang
  - ipython
  - black (19.10b0)
  - plantuml
  - sphinxcontrib-plantuml
  - documenteer
- w_2020_28
  - lsst_distrib (tag: w_2020_28)
  - lsst_sims (tag: sims_w_2020_28)
  - csh
  - graphviz
  - ipython
  - black (19.10b0)
  - plantuml
  - sphinxcontrib-plantuml
  - documenteer
- w_2020_21
  - lsst_distrib (tag: w_2020_21)
  - lsst_sims (tag: sims_w_2020_21)
  - csh
  - graphviz
  - ipython
  - black
  - plantuml
  - sphinxcontrib-plantuml
  - documenteer
- w_2020_15
  - lsst_distrib (tag: w_2020_15)
  - lsst_sims (tag: sims_w_2020_15)
  - ipython
  - scikit-image
- w_2020_14
  - lsst_distrib (tag: w_2020_14)
  - lsst_sims (tag: sims_w_2020_14)
  - ipython
  - scikit-image
- w_2020_07
  - lsst_distrib (tag: w_2020_07)
  - lsst_sims (tag: sims_w_2020_07)
  - ipython
  - scikit-image
- w_2020_06
  - lsst_distrib (tag: w_2020_06)
  - lsst_sims (tag: sims_w_2020_06)
  - ipython
  - scikit-image
- w_2020_04
  - lsst_distrib (tag: w_2020_04)
  - lsst_sims (tag: sims_w_2020_04)
  - ipython
  - scikit-image
- w_2019_50
  - lsst_distrib (tag: w_2019_50)
  - lsst_sims (tag: sims_w_2019_50)
  - ipython
  - scikit-image
- w_2019_44
  - lsst_distrib (tag: w_2019_44)
  - lsst_sims (tag: sims_w_2019_44)
  - ipython
  - scikit-image
- w_2019_38_sal
  - lsst_sims (tag: sims_w_2019_38)
  - scikit-image (by conda)
  - sphinxcontrib-plantuml (by pip)
  - csh (by yum)
  - graphviz (by yum)
  - SAL related packages maintained by develop-env in ts_Dockerfiles
- w_2019_38
  - lsst_distrib (tag: w_2019_38)
  - lsst_sims (tag: sims_w_2019_38)
  - ipython
  - scikit-image
