#! /usr/bin/env bash

set -e

./apt_basic_devel.sh
./apt_audio_base.sh
./apt_pkg_db_updates.sh
./install_miniaudicle.sh
