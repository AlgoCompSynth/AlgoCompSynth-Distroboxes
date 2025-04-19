#! /usr/bin/env bash

set -e

for option in \
  RStudio_Server \
  JupyterLab \
  miniAudicle_from_source
do
  echo ""
  echo "$option:"
  sleep 15
  pushd $option
  ./0_do_all.sh
  popd
done
