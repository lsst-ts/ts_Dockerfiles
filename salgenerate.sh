#!/bin/sh

source /home/docker/ts_sal/setup.env
cd /home/docker/ts_sal/test
salgenerator Test validate
salgenerator Test sal cpp
salgenerator Test sal python
salgenerator Test lib
