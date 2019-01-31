# Hexapod Software Simulator Environment

*This is the software environment for running the Hexapod software simulator.*

## Overview
This docker is based off the official centos image with everything required to
run the Hexapod software simulator. The simulator automatically starts up when 
the container is started.

This simulator is not the Hexapod simulator provided by the vendor. This is a
simulator made to accept the offset command and published the position for 
OFC testing.

The simulator automatically starts in the enabled state.

## Instructions
- *LSST_DDS_DOMAIN*
    - The default is **hexapod**
    - To change this utilize *-e LSST_DDS_DOMAIN='**NEWDOMAIN**'*
- *SAL Commanding*
    - Sending the *offset* command will change the data published by
    *Application* telemetry.

## Tag List
- *v0.1*
    - *centos* - (tag: 7.6.1810)
    - *python* - (ver: 3.6.7)
    - *ts_sal* - master branch (commit: c473240)
    - *ts_xml* - master branch (commit: 601b64e)
    - *ts_opensplice* - master branch (commit: d0661fb) using OpenSpliceDDS v6.4.1
