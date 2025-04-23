#! /usr/bin/env bash

set -e

echo "Setting FaustLive version"
export FAUSTLIVE_VERSION="2.5.19"
export FAUSTLIVE_URL="https://github.com/grame-cncm/faustlive.git"
export FAUSTLIVE_PATH="$HOME/Projects/faustlive"
export FAUSTLIVE_SCRIPT=$PWD/FaustLive

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_faustlive.log
rm --force $LOGFILE

# https://github.com/grame-cncm/faustlive/blob/master/Build/README.md
echo "Installing build dependencies"
export DEBIAN_FRONTEND="noninteractive"
/usr/bin/time sudo apt-get install --assume-yes --no-install-recommends \
  qtbase5-dev \
  qtwayland5 \
  >> $LOGFILE 2>&1

mkdir --parents $FAUSTLIVE_PATH
rm --force --recursive $FAUSTLIVE_PATH
pushd $HOME/Projects
  echo ""
  echo "Cloning FaustLive source repo"
  /usr/bin/time git clone --recursive $FAUSTLIVE_URL \
    >> $LOGFILE 2>&1
popd

pushd $FAUSTLIVE_PATH/Build
  echo ""
  echo "Building FaustLive"
  git checkout $FAUSTLIVE_VERSION
  /usr/bin/time make \
    >> $LOGFILE 2>&1
  echo "Installing FaustLive"
  cp $FAUSTLIVE_SCRIPT $HOME/.local/bin
popd

echo "Finished"
