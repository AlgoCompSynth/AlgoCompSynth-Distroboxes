#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
export LOGFILE=$PWD/Logs/developer_packages.log

echo "Installing R developer packages - this takes some time"
/usr/bin/time ./developer_packages.R \
  >> $LOGFILE 2>&1

echo "Finished"
