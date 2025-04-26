#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_vcvrack.log
rm --force $LOGFILE

echo "Installing build dependencies"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  jq \
  libglew-dev \
  libxcursor-dev \
  libxi-dev \
  libxinerama-dev \
  libxrandr-dev \
  >> $LOGFILE 2>&1

mkdir --parents $HOME/Projects
pushd $HOME/Projects
  echo "Cloning repositories"
  rm --force --recursive Rack VCVBook
  /usr/bin/time git clone \
    https://github.com/VCVRack/Rack.git \
    >> $LOGFILE 2>&1
  /usr/bin/time git clone \
    https://github.com/LOGUNIVPM/VCVBook.git \
    >> $LOGFILE 2>&1
popd

pushd $HOME/Projects/Rack
  echo "Fetching Rack submodules"
  /usr/bin/time git submodule update --init --recursive \
    >> $LOGFILE 2>&1

  echo "make dep"
  /usr/bin/time make dep \
    >> $LOGFILE 2>&1

  echo "make"
  /usr/bin/time make --jobs=`nproc` \
    >> $LOGFILE 2>&1

popd

cp -rp $HOME/Projects/VCVBook/ABC $HOME/Projects/Rack/plugins

pushd $HOME/Projects/Rack/plugins/ABC
  echo "Building ABC plugin"
  /usr/bin/time make --jobs=`nproc` \
    >> $LOGFILE 2>&1
popd

echo "Installing 'Rack' script"
cp Rack $HOME/.local/bin/

echo "Finished"
