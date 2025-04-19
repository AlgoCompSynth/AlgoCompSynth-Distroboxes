#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/2_basic_devel.log"
rm --force $LOGFILE

echo "Adding $USER to the 'audio' group"
sudo usermod -aG audio $USER

echo "Installing basic development packages"
export DEBIAN_FRONTEND="noninteractive"
/usr/bin/time sudo apt-get update \
/usr/bin/time sudo apt-get upgrade --assume-yes \
/usr/bin/time sudo apt-get install --assume-yes --no-install-recommends \
  apt-file \
  bash-completion \
  build-essential \
  cmake \
  curl \
  file \
  gettext \
  lsb-release \
  lynx \
  man-db \
  minicom \
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
