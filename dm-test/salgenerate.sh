#!/bin/sh

source /home/lsst/repos/ts_sal/setup.env
cd /home/lsst/repos/ts_sal/test

salgenerator Test validate
salgenerator Test sal cpp
salgenerator Test html
salgenerator Test sal python
salgenerator Test lib

salgenerator ATDome validate
salgenerator ATDome sal cpp
salgenerator ATDome html
salgenerator ATDome sal python
salgenerator ATDome lib
