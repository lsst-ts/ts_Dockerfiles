# MT Hexapod CSC with SAL

*This is the software of the main telescope hexapod CSC to integrate with software abstraction layer (SAL).*

## Overview

*The scientific pipeline (lsst_distrib) is installed with the SAL related packages. The ts_sal, ts_xml, ts_idl, ts_hexrotcomm, and ts_hexapod are in the **/home/saluser/repos** directory. The idl of Rotator and Hexapod are generated already.*

## Use Of CSC

*The command of `run_hexapod.py [index]` is to run the hexapod CSC (index: 1=Camera, 2=M2). Use the argument of `-s` to enter the simulation mode. The command of `command_hexapod.py [index]` can be used to command the hexapod in an interactive environment.*

## Tag List

- *v0.2.1*
    - *ts_sal - develop branch (commit: 5baf80d)*
    - *ts_xml - develop branch (commit: f088b35)*
    - *ts_salobj - develop branch (commit: 939f1d5)*
    - *ts_idl - develop branch (commit: 4dafc4f)*
    - *ts_hexrotcomm - develop branch (commit: 131dd7a)*
    - *ts_hexapod - develop branch (commit: ebe6c05)*
