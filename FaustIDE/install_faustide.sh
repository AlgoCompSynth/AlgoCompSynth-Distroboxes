#! /usr/bin/env bash

set -e

export FAUSTIDE_URL="https://github.com/grame-cncm/faustide.git --depth 1"
export FAUSTIDE_PATH="$HOME/Projects/faustide"
export FAUSTIDE_SCRIPT=$PWD/FaustIDE

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_faustide.log
rm --force $LOGFILE

echo "Installing build dependencies"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  npm \
  >> $LOGFILE 2>&1

# https://github.com/grame-cncm/faustlive/blob/master/Build/README.md
mkdir --parents $FAUSTIDE_PATH
rm --force --recursive $FAUSTIDE_PATH
pushd $HOME/Projects
  echo ""
  echo "Cloning FaustIDE source repo"
  /usr/bin/time git clone $FAUSTIDE_URL \
    >> $LOGFILE 2>&1
popd

pushd $FAUSTIDE_PATH
  echo ""
  echo "Building FaustIDE"
  /usr/bin/time npm install \
    >> $LOGFILE 2>&1
  /usr/bin/time npm update \
    >> $LOGFILE 2>&1
  /usr/bin/time npm run build \
    >> $LOGFILE 2>&1
  echo "Installing FaustIDE"
  cp $FAUSTIDE_SCRIPT $HOME/.local/bin
popd

echo "Finished"
