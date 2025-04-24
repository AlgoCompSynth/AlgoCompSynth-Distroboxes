#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
export LOGFILE=$PWD/Logs/audio_packages.log

echo "Installing R audio packages - this takes some time"
/usr/bin/time ./audio_packages.R \
  >> $LOGFILE 2>&1

echo "Cloning consonaR"
mkdir --parents $HOME/Projects
pushd $HOME/Projects
  rm -fr consonaR
  /usr/bin/time git clone git@github.com:AlgoCompSynth/consonaR.git \
  >> $LOGFILE 2>&1
popd

echo "Cloning eikosany"
pushd $HOME/Projects
  rm -fr eikosany
  /usr/bin/time git clone git@github.com:AlgoCompSynth/eikosany.git \
  >> $LOGFILE 2>&1
popd

echo "Finished"
