# Software Environment of AOS with SAL

This is the software environment for active optics system (AOS) to integrate with software abstraction layer (SAL).

## Overview

The scientific pipeline is installed with the lsst_distrib and lsst_sims packages. This Dockerfile will be removed after AOS does not need the lsst_sims anymore.

## Tag List

- w_2020_16_sal
  - lsst_sims (tag: sims_w_2020_16)
  - scikit-image (by conda)
  - sphinxcontrib-plantuml (by pip)
  - csh (by yum)
  - SAL related packages maintained by develop-env in ts_Dockerfiles
- w_2020_15_sal
  - lsst_sims (tag: sims_w_2020_15)
  - scikit-image (by conda)
  - sphinxcontrib-plantuml (by pip)
  - csh (by yum)
  - SAL related packages maintained by develop-env in ts_Dockerfiles
- w_2020_14_sal
  - lsst_sims (tag: sims_w_2020_14)
  - scikit-image (by conda)
  - sphinxcontrib-plantuml (by pip)
  - csh (by yum)
  - SAL related packages maintained by develop-env in ts_Dockerfiles
- w_2020_06_sal
  - lsst_sims (tag: sims_w_2020_06)
  - ipython (by conda)
  - scikit-image (by conda)
  - sphinxcontrib-plantuml (by pip)
  - csh (by yum)
  - graphviz (by yum)
  - SAL related packages maintained by develop-env in ts_Dockerfiles
- w_2019_02
    - lsst_distrib (tag: w_2019_02)
    - lsst_sims (tag: sims_w_2019_02)
    - ts_sal - master branch (commit: c473240)
    - ts_xml - master branch (commit: 601b64e)
    - ts_opensplice - master branch (commit: d0661fb) with OpenSpliceDDS v6.4.1
    - ts_m1m3support - develop branch (commit: 27ce004)
