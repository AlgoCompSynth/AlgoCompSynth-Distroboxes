#! /usr/bin/env bash

set -e

echo "Setting Faust version"
export FAUST_VERSION="2.79.3"
export FAUST_URL="https://github.com/grame-cncm/faust/releases/download/${FAUST_VERSION}/faust-${FAUST_VERSION}.tar.gz"
export FAUST_PATH="$HOME/Projects/faust-${FAUST_VERSION}"
echo "${FAUST_PATH}"

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_faust.log
rm --force $LOGFILE

# https://github.com/grame-cncm/faust/wiki/Building
mkdir --parents $FAUST_PATH
rm --force --recursive $FAUST_PATH
pushd $HOME/Projects
  echo ""
  echo "Downloading Faust source"
  curl -sL "${FAUST_URL}" \
    | tar xzf -
popd

pushd $FAUST_PATH
  echo ""
  echo "Building Faust"
  /usr/bin/time make all \
    >> $LOGFILE 2>&1
  echo "Installing Faust"
  sudo make install \
    >> $LOGFILE 2>&1
popd

echo "Finished"
