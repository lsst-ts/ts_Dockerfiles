# MTM1M3 Software Simulator Environment

*This is the software environment for running the MTM1M3 software simulators.*

## Overview
This docker is based off the official Centos image with everything required to
run the MTM1M3 software simulators. The simulator automatically starts up when
the container is started. Builds SS (Support System), TS (Thermal System)
binaries and VMS (Vibration Monitoring System) binaries.

## Build arguments
Those arguments can be branch names or git tags.

* **M1M3_BRANCH** used as default if the argument isn't set. Itself defaults to
  develop
* **XML_BRANCH** ts_xml branch/tag
* **CRIOCPP_BRANCH** ts_cRIOcpp branch/tag
* **M1M3SUPPORT_BRANCH** ts_m1m3support branch/tag
* **M1M3THERMAL_BRANCH** ts_m1m3thermal branch/tag
* **VMS_BRANCH** ts_vms branch/tag

## Container arguments

Without any arguments, a shell with environment setup to run SAL/DDS software
will be opened. Those arguments (case insensitive) are supported:

* **bare** starts bare environment. SAL/DDS isn't setup
* **SS** starts and runs M1M3 Support System simulator
* **TS** starts and runs M1M3 Thermal System simulator
* **VMS** starts and runs VMS simulator(s) - either one of M1M3, M2 or
  CameraRotator (Rotator), or all three (if name isn't specified)
* **command** or **cmd** runs SAL/DDS commands - see below

### Running SAL/DDS commands

When running the SAL/DDS commands with cmd/command argument, following
arguments have to be provided:

1. name of subsystem - **SS**, **TS** or **VMS**
2. SAL/DDS command to run - **start**, **exitControl**, ..
3. SAL/DDS command arguments - SAL/DDS command specific

### Examples

Assuming the container was build with tag m1m3_sim (*docker build -t m1m3_sim
.*):

```
# starts M1M3 Support System
docker run -ti m1m3_sim SS
# commands M1M3 Support System start
docker run -ti m1m3_sim cmd SS start Default
```

To end M1M3 Static Support, you can then execute:

```
docker run -ti m1m3_sim cmd SS start standby
docker run -ti m1m3_sim cmd SS start exitControl
```
