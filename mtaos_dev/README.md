# MT AOS Software Development Environment

*This is the software environment for developing the MT AOS software.*

## Overview
This docker is based off the lsstts/aos_aoclc image with everything required to
develop the MT AOS software.

## Instructions
- *LSST_DDS_DOMAIN*
    - The default is **mtaos**
    - To change this utilize *-e LSST_DDS_DOMAIN='**NEWDOMAIN**'*
- sudo docker run -it --net host --rm -u root -v /home/ccontaxis/Code/ts_MTAOS:/home/lsst/ts_MTAOS/ lsstts/mtaos_dev:v0.1

## Tag List
- *v0.1*
    - *python* - (ver: 3.6.7)
    - *ts_sal* - develop branch (commit: 10d2039e33031f9d10ecd4fef776e25f99eb79a2)
    - *ts_xml* - develop branch (commit: e644c6b7d1a8dec77ae7fa2e1db92118b1d05893)
    - *ts_opensplice* - master branch (commit: d0661fb) using OpenSpliceDDS v6.4.1
    - *ts_salobj* - master branch (commit: abfecf20819721c021980dd9abde7189d9edd743)
