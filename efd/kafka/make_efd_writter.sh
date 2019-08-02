#!/usr/bin/env bash

cp ~/repos/ts_xml/sal_interfaces/*xml .
cp ~/repos/ts_xml/sal_interfaces/$1/*xml .

salgenerator $1 validate && salgenerator ${1} html && salgenerator ${1} sal cpp &&  salgenerator ${1} lib

