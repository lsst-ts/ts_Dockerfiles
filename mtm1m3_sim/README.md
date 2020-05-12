# MTM1M3 Software Simulator Environment

*This is the software environment for running the MTM1M3 software simulator.*

## Overview
This docker is based off the official centos image with everything required to
run the MTM1M3 software simulator. The simulator automatically starts up when 
the container is started.

## Instructions
- *LSST_DDS_DOMAIN*
    - The default is **m1m3**
    - To change this utilize *-e LSST_DDS_DOMAIN='**NEWDOMAIN**'*
- *SAL Commanding*
    - Send the "start" command with argument "Simulator". (This will start publishing data at 50Hz)
    - Send the "enable" command and then "raiseM1M3" command. Once the detailedState is ActiveState then the simulator can accept the "applyActiveOpticForces" command.

## Tag List
- *v1.7*
    - lsstts/develop-env:b68
    - *ts_sal* develop (includes salgenerator generate command)
    - *ts_m1m3support* v1.7

- *v1.6*
    - *centos* - (tag: 7.6.1810)
    - *python* - (ver: 3.6.7)
    - *ts_sal* - develop branch (commit: 18cd34ecc0fd484550c8de78b06d0301863eaabd)
    - *ts_xml* - develop branch (commit: c51f11fa8a60d55879d1cebc970b7eedc37876eb)
    - *ts_opensplice* - master branch (commit: d0661fb) using OpenSpliceDDS v6.4.1
    - *ts_m1m3support* - develop branch (commit: 27ce004)
