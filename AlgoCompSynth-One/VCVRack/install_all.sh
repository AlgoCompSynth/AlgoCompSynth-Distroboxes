#! /usr/bin/env bash

set -e

./linux_dependencies.sh
../apt_pkg_db_updates.sh
./install_vcvrack.sh
