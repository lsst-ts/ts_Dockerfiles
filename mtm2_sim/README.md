# MTM2 Software Simulator Environment

*This is the software environment for running the MTM2 software simulator.*

## Overview
This docker is based off the official centos image with everything required to
run the MTM2 software simulator. The simulator automatically starts up when 
the container is started.

This simulator is not the MTM2 simulator provided by the vendor. This is a
simulator made to accept the applyForces command and published the applied
forces for OFC testing.

The simulator automatically starts in the enabled state.

## Instructions
- *LSST_DDS_DOMAIN*
    - The default is **m2**
    - To change this utilize *-e LSST_DDS_DOMAIN='**NEWDOMAIN**'*
- *SAL Commanding*
    - Sending the *applyForces* command will change the data published by
    *axialForcesMeasured* telemetry.

## Tag List
- *v0.2*
    - *centos* - (tag: 7.6.1810)
    - *python* - (ver: 3.6.7)
    - *ts_sal* - develop branch (commit: 18cd34ecc0fd484550c8de78b06d0301863eaabd)
    - *ts_xml* - develop branch (commit: c51f11fa8a60d55879d1cebc970b7eedc37876eb)
    - *ts_opensplice* - master branch (commit: d0661fb) using OpenSpliceDDS v6.4.1
    - *ts_salobj* - master branch (commit: 078ad4cab91e7fb385e89dce89a9ea530dd0f503)
- *v0.1*
    - *centos* - (tag: 7.6.1810)
    - *python* - (ver: 3.6.7)
    - *ts_sal* - master branch (commit: c473240)
    - *ts_xml* - master branch (commit: 601b64e)
    - *ts_opensplice* - master branch (commit: d0661fb) using OpenSpliceDDS v6.4.1
    - *ts_salobj* - master branch (commit: 078ad4cab91e7fb385e89dce89a9ea530dd0f503)
