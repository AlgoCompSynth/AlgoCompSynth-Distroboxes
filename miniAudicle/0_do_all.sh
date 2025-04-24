#! /usr/bin/env bash

set -e

echo "Setting ChucK version"
export CHUCK_VERSION="chuck-1.5.5.0"
echo "Setting Qt version"
export QT_SELECT=qt6

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_miniaudicle.log
rm --force $LOGFILE

export PATH=/usr/lib/qt6/bin:$PATH

mkdir --parents $HOME/Projects
pushd $HOME/Projects
  echo ""
  echo "Cloning repository"
  rm -fr miniAudicle
  /usr/bin/time git clone --recurse-submodules \
    https://github.com/ccrma/miniAudicle.git \
    >> $LOGFILE 2>&1
popd

pushd $HOME/Projects/miniAudicle/src/chuck/src
  echo ""
  echo "Building ChucK"
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=`nproc` linux-all \
    >> $LOGFILE 2>&1
  echo "Installing ChucK"
  sudo make install \
    >> $LOGFILE 2>&1
popd

pushd $HOME/Projects/miniAudicle/src/chugins
  echo ""
  echo "Building ChuGins"
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=`nproc` linux-alsa linux-jack \
    >> $LOGFILE 2>&1
  echo "Installing ChuGins"
  sudo make install \
    >> $LOGFILE 2>&1
popd

pushd $HOME/Projects/miniAudicle/src/chugins/Faust
  echo ""
  echo "Building Faust ChuGin"
  /usr/bin/time make --jobs=`nproc` linux-alsa linux-jack \
    >> $LOGFILE 2>&1
  echo "Installing Faust ChuGin"
  sudo make install \
    >> $LOGFILE 2>&1
popd

pushd $HOME/Projects/miniAudicle/src
  echo ""
  echo "Building miniAudicle"
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=`nproc` linux-all \
    >> $LOGFILE 2>&1
  echo "Installing miniAudicle"
  sudo make install \
    >> $LOGFILE 2>&1
popd

echo "Finished"
