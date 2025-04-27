#! /usr/bin/env bash

set -e

./apt_basic_devel.sh
./apt_audio_base.sh
./apt_pkg_db_updates.sh

for option in \
  RStudio_Server \
  JupyterLab
do
  echo ""
  echo "$option:"
  sleep 15
  pushd $option
  ./0_do_all.sh
  popd
done
