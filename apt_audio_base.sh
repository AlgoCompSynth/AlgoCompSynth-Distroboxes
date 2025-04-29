#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/apt_audio_base.log"
rm --force $LOGFILE

echo ""
echo "Adding $USER to the 'audio' group"
sudo usermod -aG audio $USER

echo "Installing base audio packages"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install --assume-yes --no-install-recommends \
  alsa-utils \
  audacity \
  ffmpeg \
  flac \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  fluidsynth \
  freepats \
  iannix \
  jack-tools \
  libasound2-dev \
  libasound2-plugins \
  libcanberra-gtk3-module \
  libjack-jackd2-dev \
  libpulse-dev \
  libsndfile1-dev \
  libsox-fmt-all \
  libsoxr0 \
  mp3splt \
  pipewire \
  polyphone \
  pulseaudio \
  pulseaudio-utils \
  qjackctl \
  sf3convert \
  sndfile-tools \
  sox \
  timidity \
  wireplumber-doc \
  >> $LOGFILE 2>&1

echo "Finished"
