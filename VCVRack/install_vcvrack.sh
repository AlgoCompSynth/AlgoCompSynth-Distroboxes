#! /usr/bin/env bash

set -e

echo ""
echo "*** VCVRack ***"

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_vcvrack.log
rm --force $LOGFILE

mkdir --parents $HOME/Projects
echo "Cloning repositories"
pushd $HOME/Projects
  rm --force --recursive Rack VCVBook
  /usr/bin/time git clone \
    https://github.com/VCVRack/Rack.git \
    >> $LOGFILE 2>&1
  /usr/bin/time git clone \
    https://github.com/LOGUNIVPM/VCVBook.git \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Fetching Rack submodules"
pushd $HOME/Projects/Rack
  /usr/bin/time git submodule update --init --recursive \
    >> $LOGFILE 2>&1

  echo "make dep"
  /usr/bin/time make dep \
    >> $LOGFILE 2>&1

  echo "make"
  /usr/bin/time make --jobs=`nproc` \
    >> $LOGFILE 2>&1

popd > /dev/null

cp -rp $HOME/Projects/VCVBook/ABC $HOME/Projects/Rack/plugins

echo "Building ABC plugin"
pushd $HOME/Projects/Rack/plugins/ABC
  /usr/bin/time make --jobs=`nproc` \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Installing 'Rack' script"
cp Rack $HOME/.local/bin/

echo "Finished"
