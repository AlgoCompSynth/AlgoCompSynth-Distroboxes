#! /usr/bin/env bash

set -e

./apt_audio_base.sh
./apt_pkg_db_updates.sh

for option in \
  VCVRack \
  FaucK \
  RStudio_Server \
  JupyterLab
do
  echo ""
  echo "$option:"
  sleep 15
  pushd $option
  ./install_all.sh
  popd
done
