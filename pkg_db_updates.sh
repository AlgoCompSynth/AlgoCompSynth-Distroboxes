#! /usr/bin/env bash

set -e

echo "Updating packages"
export DEBIAN_FRONTEND="noninteractive"
sudo apt-get update -qq && sudo apt-get upgrade -qqy

echo "Updating apt-file database"
sudo apt-file update

echo "Updating locate database"
sudo updatedb

echo "Updating manual database"
sudo mandb

echo "Finished"
