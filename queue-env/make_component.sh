#!/usr/bin/env bash

salgenerator $1 validate
salgenerator $1 html
salgenerator $1 sal cpp
salgenerator $1 python
salgenerator $1 lib
