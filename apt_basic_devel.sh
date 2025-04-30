#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/apt_basic_devel.log"
rm --force $LOGFILE

echo "Installing basic development packages"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install --assume-yes --no-install-recommends \
  apt-file \
  automake \
  bash-completion \
  build-essential \
  cmake \
  curl \
  file \
  gettext \
  libtool \
  libusb-1.0-0-dev \
  lsb-release \
  lynx \
  man-db \
  minicom \
  ninja-build \
  pkg-config \
  plocate \
  python3-dev \
  python3-pip \
  python3-setuptools \
  python3-venv \
  python3-wheel \
  screen \
  speedtest-cli \
  tmux \
  tree \
  unzip \
  usbutils \
  wget \
  >> $LOGFILE 2>&1

echo "Finished"
