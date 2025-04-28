#! /usr/bin/env bash

set -e

echo "Setting Faust version"
export FAUST_VERSION="2.79.3"
export FAUST_URL="https://github.com/grame-cncm/faust.git"
export FAUST_PATH="$HOME/Projects/faust"

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_faust.log
rm --force $LOGFILE

echo "Installing build dependencies"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  libmicrohttpd-dev \
  libpolly-18-dev \
  libzstd-dev \
  llvm \
  llvm-dev \
  >> $LOGFILE 2>&1
#export PATH=$PATH:/usr/lib/llvm-18/bin/

# https://github.com/grame-cncm/faust/wiki/Building
mkdir --parents $FAUST_PATH
rm --force --recursive $FAUST_PATH
pushd $HOME/Projects
  echo ""
  echo "Cloning Faust repository"
  /usr/bin/time git clone --recursive ${FAUST_URL} \
    >> $LOGFILE 2>&1
popd

pushd $FAUST_PATH
  echo ""
  echo "Building Faust"
  git checkout ${FAUST_VERSION} \
    >> $LOGFILE 2>&1
  /usr/bin/time make all \
    >> $LOGFILE 2>&1
  echo "Installing Faust"
  sudo make install \
    >> $LOGFILE 2>&1
popd

echo "Finished"
