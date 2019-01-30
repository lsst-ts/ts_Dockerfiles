# MTM1M3 Software Simulator Environment

*This is the software environment for running the MTM1M3 software simulator.*

## Overview
This docker is based off the official centos image with everything required to
run the MTM1M3 software simulator. The simulator automatically starts up when 
the container is started.

## Tag List
- *v1.6*
    - *centos* - (tag: 7.6.1810)
    - *python* - (ver: 3.6.7)
    - *ts_sal* - master branch (commit: c473240)
    - *ts_xml* - master branch (commit: 601b64e)
    - *ts_opensplice* - master branch (commit: d0661fb) using OpenSpliceDDS v6.4.1
    - *ts_m1m3support* - develop branch (commit: 27ce004)
