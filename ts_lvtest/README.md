# ts_LVTest Environment

*This is the software environment for running the LabVIEW Test CSC.*

## Overview
This docker is based off the official centos image with everything required to
run the LabVIEW Test CSC. The simulator automatically starts up when 
the container is started.

## Instructions
- *LSST_DDS_DOMAIN*
    - The default is **lvtest**
    - To change this utilize *-e LSST_DDS_DOMAIN='**NEWDOMAIN**'*
- *LVTEST_INDEX*
    - The SAL index to use for the CSC
    - If unset it defaults to index 0
