#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/linux_deps.log"
rm --force $LOGFILE

echo "Adding CRAN repository"
# https://cran.rstudio.com/bin/linux/ubuntu/

# add the signing key (by Michael Rutter) for these repos
# To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc \
  | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed
sudo add-apt-repository --yes \
  "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" \
  >> $LOGFILE 2>&1

echo "Upgrading base packages"
export DEBIAN_FRONTEND="noninteractive"
/usr/bin/time sudo apt-get update \
  >> $LOGFILE 2>&1
/usr/bin/time sudo apt-get upgrade --assume-yes \
  >> $LOGFILE 2>&1

echo ""
echo ""
echo "Installing 'jackd2'. There appears to be no way to keep"
echo "it from configuring the realtime process priority"
echo "option when the install runs in the background."
echo ""
echo "The default of 'No' is safest; if you want to experiment"
echo "with realtime priority later, you can change it by running"
echo ""
echo "    sudo dpkg-reconfigure jackd2"
echo ""
read -p "Press 'Enter' to continue:"

/usr/bin/time sudo apt-get install -qqy --no-install-recommends jackd2

echo ""
echo "Adding $USER to the 'audio' group"
sudo usermod -aG audio $USER

echo "Installing Linux dependencies"
/usr/bin/time sudo apt-get install --assume-yes --no-install-recommends \
  alsa-utils \
  apt-file \
  audacity \
  autoconf \
  automake \
  bash-completion \
  bison \
  blepvco \
  blop \
  build-essential \
  byacc \
  cmake \
  cmt \
  curl \
  dssi-dev \
  dssi-utils \
  fakeroot \
  ffmpeg \
  ffmpeg-doc \
  file \
  fil-plugins \
  flac \
  flex \
  flite1-dev \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  fluidsynth \
  freepats \
  gdb \
  gdebi-core \
  gettext \
  git \
  iannix \
  invada-studio-plugins-ladspa \
  jack-tools \
  jq \
  ladspa-sdk \
  libasound2-dev \
  libasound2-plugins \
  libavfilter-dev \
  libavifile-0.7-dev \
  libbluetooth-dev \
  libcanberra-gtk3-module \
  libcrypto++-dev \
  libcurl4-openssl-dev \
  libdc1394-dev \
  libffmpeg-nvenc-dev \
  libfftw3-dev \
  libfftw3-doc \
  libfluidsynth-dev \
  libfontconfig1-dev \
  libfreetype6-dev \
  libfribidi-dev \
  libftgl-dev \
  libgit2-dev \
  libgl1-mesa-dev \
  libglew-dev \
  libglu1-mesa-dev \
  libgmerlin-avdec-dev \
  libgmerlin-dev \
  libgsl0-dev \
  libgsm1-dev \
  libgtk2.0-dev \
  libharfbuzz-dev \
  libjack-jackd2-dev \
  libjpeg-dev \
  liblua5.4-dev \
  libmagick++-dev \
  libmicrohttpd-dev \
  libmp3lame-dev \
  libmpeg3-dev \
  libnss3 \
  libpng-dev \
  libpolly-18-dev \
  libpulse-dev \
  libqscintilla2-qt6-dev \
  libquicktime-dev \
  libraw1394-dev \
  libsmpeg0 \
  libsndfile1-dev \
  libsox-dev \
  libsox-fmt-all \
  libsoxr0 \
  libsoxr-dev  \
  libsoxr-dev \
  libspeex-dev \
  libssl-dev \
  libstk-dev \
  libtiff5-dev \
  libtirpc-dev \
  libtool \
  libudev-dev \
  libv4l-dev \
  libvorbis-dev \
  libx11-dev \
  libxcursor-dev \
  libxi-dev zlib1g-dev \
  libxinerama-dev \
  libxml2-dev \
  libxrandr-dev \
  libzstd-dev \
  llvm \
  llvm-dev \
  lsb-release \
  lynx \
  man-db \
  mcp-plugins \
  mda-lv2 \
  minicom \
  mp3splt \
  ninja-build \
  omins \
  patchelf \
  pipewire \
  pkg-config \
  plocate \
  polyphone \
  portaudio19-dev \
  pulseaudio \
  pulseaudio-utils \
  python3-dev \
  python3-pip \
  python3-setuptools \
  python3-venv \
  python3-wheel \
  qjackctl \
  qpdf \
  qt6-base-dev \
  qt6-wayland \
  qt6-wayland-dev \
  qtbase5-dev \
  qtwayland5 \
  r-base \
  r-base-dev \
  rev-plugins \
  rsync \
  screen \
  sf3convert \
  sndfile-tools \
  sox \
  speedtest-cli \
  swh-plugins \
  tap-plugins \
  timidity \
  tmux \
  tree \
  unzip \
  upower \
  usbutils \
  vco-plugins \
  wah-plugins \
  wget \
  wireplumber-doc \
  >> $LOGFILE 2>&1

echo "Finished"
