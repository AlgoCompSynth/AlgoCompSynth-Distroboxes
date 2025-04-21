#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
export LOGFILE=$PWD/Logs/audio_packages.log

echo "Installing Linux dependencies"
export DEBIAN_FRONTEND="noninteractive"
/usr/bin/time sudo apt-get install --assume-yes --no-install-recommends \
  cmake \
  flac \
  ffmpeg \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  libavfilter-dev \
  libcurl4-openssl-dev \
  libfftw3-dev \
  libfftw3-doc \
  libfluidsynth-dev \
  libmagick++-dev \
  libsox-dev \
  libsox-fmt-all  \
  libsoxr-dev  \
  mp3splt \
  sox \
  >> $LOGFILE 2>&1

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
