#! /usr/bin/env bash

set -e

./terminal_setup.sh
./apt_audio_base.sh
./apt_pkg_db_updates.sh

for option in \
  RStudio_Server \
  JupyterLab \
  FaucK \
  VCVRack
do
  echo ""
  echo "$option:"
  sleep 15
  pushd $option
  ./install_all.sh
  popd
done
