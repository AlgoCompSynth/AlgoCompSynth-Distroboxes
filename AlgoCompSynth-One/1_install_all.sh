#! /usr/bin/env bash

set -e

./terminal_setup.sh
./apt_basic_devel.sh
./apt_audio_base.sh

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

./apt_pkg_db_updates.sh
