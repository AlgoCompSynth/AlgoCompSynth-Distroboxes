#! /usr/bin/env bash

set -e

for option in \
  Pd-L2Ork \
  RStudio_Server \
  JupyterLab \
  Faust \
  miniAudicle \
  vcvrack_dev
do
  echo ""
  echo "$option:"
  sleep 15
  pushd $option
  ./0_do_all.sh
  popd
done
