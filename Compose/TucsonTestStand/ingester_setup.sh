#!/usr/bin/env bash

# Source this file when starting the container to set it up

echo "#"
echo "# Loading LSST Stack"
. /opt/lsst/software/stack/loadLSST.bash
setup lsst_distrib

echo "#"
echo "# Starting ingest watcher"

cd
cd ingest/dds_scripts

while :
  do
    python ingest_watcher.py 2>&1
done
