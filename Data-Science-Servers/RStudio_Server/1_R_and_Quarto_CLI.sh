#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
export LOGFILE=$PWD/Logs/R_and_Quarto_CLI.log

echo ""
echo "Installing software-properties-common"
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  software-properties-common \
  >> $LOGFILE 2>&1

# https://cran.r-project.org/bin/linux/ubuntu/
# add the signing key (by Michael Rutter) for these repos
# To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
# Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc \
  | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# add the repo from CRAN -- lsb_release adjusts to 'noble' or 'jammy' or ... as needed
sudo add-apt-repository --yes "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

echo ""
echo "Installing R"
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  qpdf \
  r-base \
  r-base-dev \
  >> $LOGFILE 2>&1
echo ""
echo "R --version: `R --version`"
echo ""
echo ""

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
