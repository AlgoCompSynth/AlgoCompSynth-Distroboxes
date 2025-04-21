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
echo "Installing build dependencies"
export DEBIAN_FRONTEND="noninteractive"
/usr/bin/time sudo apt-get install --assume-yes --no-install-recommends \
  autoconf \
  automake \
  bison \
  blepvco \
  blop \
  byacc \
  cmake \
  cmt \
  dssi-dev \
  dssi-utils \
  fakeroot \
  fil-plugins \
  flex \
  flite1-dev \
  fluid-soundfont-gm \
  git \
  invada-studio-plugins-ladspa \
  ladspa-sdk \
  libasound2-dev \
  libavifile-0.7-dev \
  libbluetooth-dev \
  libcanberra-gtk3-module \
  libdc1394-dev \
  libfftw3-dev \
  libfluidsynth-dev \
  libftgl-dev \
  libgl1-mesa-dev \
  libglew-dev \
  libglu1-mesa-dev \
  libgmerlin-avdec-dev \
  libgmerlin-dev \
  libgsl0-dev \
  libgsm1-dev \
  libgtk2.0-dev \
  libjack-jackd2-dev \
  libjpeg-dev \
  liblua5.4-dev \
  libmagick++-dev \
  libmp3lame-dev \
  libmpeg3-dev \
  libnss3 \
  libquicktime-dev \
  libraw1394-dev \
  libsmpeg0 \
  libspeex-dev \
  libstk-dev \
  libtirpc-dev \
  libtool \
  libudev-dev \
  libv4l-dev \
  libvorbis-dev \
  mcp-plugins \
  mda-lv2 \
  ninja-build \
  omins \
  patchelf \
  portaudio19-dev \
  python3-dev \
  rev-plugins \
  rsync \
  swh-plugins \
  tap-plugins \
  upower \
  vco-plugins \
  wah-plugins \
  wget \
  >> $LOGFILE 2>&1

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
