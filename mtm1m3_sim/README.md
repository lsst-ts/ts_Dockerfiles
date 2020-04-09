# MTM1M3 Software Simulator Environment

This is the software environment for running the MTM1M3 software simulator.

## Overview

This docker is based off the official develop-env image with everything
required to run the MTM1M3 software simulator. The simulator automatically
starts up when the container is started.

## Instructions
- *SAL Commanding*
  - Send the "start" command with argument "Simulator". (This will start publishing data at 50Hz)
  - Send the "enable" command and then "raiseM1M3" command. Once the detailedState is ActiveState then the simulator can accept the "applyActiveOpticForces" command.
