#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
export LOGFILE=$PWD/Logs/developer_packages.log

echo "Installing Linux dependencies"
export DEBIAN_FRONTEND="noninteractive"
/usr/bin/time sudo apt-get install --assume-yes --no-install-recommends \
  libcurl4-openssl-dev \
  libfontconfig1-dev \
  libfreetype6-dev \
  libfribidi-dev \
  libgit2-dev \
  libharfbuzz-dev \
  libjpeg-dev \
  libmagick++-dev \
  libpng-dev \
  libtiff5-dev \
  libxml2-dev \
  qpdf \
  >> $LOGFILE 2>&1

echo "Installing R developer packages - this takes some time"
/usr/bin/time ./developer_packages.R \
  >> $LOGFILE 2>&1

echo "Finished"
