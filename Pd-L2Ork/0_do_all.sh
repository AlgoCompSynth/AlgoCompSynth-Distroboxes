#! /usr/bin/env bash

set -e

echo "Setting Pd-L2Ork version"
export PD_L2ORK_VERSION="20250223-rev.9ad0930e"
export PD_L2ORK_URL="https://github.com/pd-l2ork/pd-l2ork.git"
export PD_L2ORK_PATH="$HOME/Projects/pd-l2ork"

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_pd-l2ork.log
rm --force $LOGFILE

# https://github.com/pd-l2ork/pd-l2ork?tab=readme-ov-file#linux
mkdir --parents $PD_L2ORK_PATH
rm --force --recursive $PD_L2ORK_PATH
pushd $HOME/Projects
  echo ""
  echo "Downloading Pd-L2Ork source"
  /usr/bin/time git clone --recursive --branch $PD_L2ORK_VERSION $PD_L2ORK_URL \
    >> $LOGFILE 2>&1
popd

pushd $PD_L2ORK_PATH
  echo ""
  echo "Building Pd-L2Ork"
  /usr/bin/time make --jobs=`nproc` all \
    >> $LOGFILE 2>&1
  echo "Installing Pd-L2Ork"
  sudo make install \
    >> $LOGFILE 2>&1
popd

echo "Finished"
