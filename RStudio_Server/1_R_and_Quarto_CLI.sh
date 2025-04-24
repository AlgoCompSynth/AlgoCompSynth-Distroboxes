#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
export LOGFILE=$PWD/Logs/R_and_Quarto_CLI.log

echo "Setting R profiles $HOME/.Rprofile and $HOME/.Renviron"
cp Rprofile $HOME/.Rprofile
# https://forum.posit.co/t/timedatectl-had-status-1/72060/5
cp Renviron $HOME/.Renviron
echo ""

echo ""
echo "Installing Quarto CLI"
export QUARTO_VERSION=1.6.43
pushd /tmp
rm -f *.deb
wget --quiet https://github.com/quarto-dev/quarto-cli/releases/download/v$QUARTO_VERSION/quarto-$QUARTO_VERSION-linux-amd64.deb
/usr/bin/time sudo dpkg -i quarto-$QUARTO_VERSION-linux-amd64.deb \
  >> $LOGFILE 2>&1
popd

echo ""
echo "Finished!"
