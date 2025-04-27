#! /usr/bin/env bash

set -e

./terminal_setup.sh
./apt_basic_devel.sh
./apt_audio_base.sh
./install_faust.sh
./install_faustlive.sh
./apt_pkg_db_updates.sh
