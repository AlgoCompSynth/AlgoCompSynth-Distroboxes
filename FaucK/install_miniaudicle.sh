#! /usr/bin/env bash

set -e

echo ""
echo "*** miniAudicle ***"

echo "Setting ChucK version"
export CHUCK_VERSION="chuck-1.5.5.0"
echo "Setting Qt version"
export QT_SELECT=qt6
export PATH=/usr/lib/qt6/bin:$PATH

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_miniaudicle.log
rm --force $LOGFILE

mkdir --parents $HOME/Projects
echo ""
echo "Cloning repository"
pushd $HOME/Projects
  rm -fr miniAudicle
  /usr/bin/time git clone --recurse-submodules \
    https://github.com/ccrma/miniAudicle.git \
    >> $LOGFILE 2>&1
popd > /dev/null

echo ""
echo "Building ChucK"
pushd $HOME/Projects/miniAudicle/src/chuck/src
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=`nproc` linux-alsa \
    >> $LOGFILE 2>&1
  echo "Installing ChucK"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo ""
echo "Building ChuGins"
pushd $HOME/Projects/miniAudicle/src/chugins
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=`nproc` linux-alsa \
    >> $LOGFILE 2>&1
  echo "Installing ChuGins"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo ""
echo "Building Faust ChuGin"
pushd $HOME/Projects/miniAudicle/src/chugins/Faust
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=`nproc` linux-alsa \
    >> $LOGFILE 2>&1
  echo "Installing Faust ChuGin"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo ""
echo "Building FluidSynth ChuGin"
pushd $HOME/Projects/miniAudicle/src/chugins/FluidSynth
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=`nproc` linux-alsa \
    >> $LOGFILE 2>&1
  echo "Installing FluidSynth ChuGin"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo ""
echo "Building miniAudicle"
pushd $HOME/Projects/miniAudicle/src
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=`nproc` linux-alsa \
    >> $LOGFILE 2>&1
  echo "Installing miniAudicle"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Finished"
