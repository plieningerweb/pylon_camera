#!/bin/bash
if ( [ "${PYLON_ROOT}" != "" ] && [ -d "${PYLON_ROOT}" ] ); then
  MAJOR=`${PYLON_ROOT}/bin/pylon-config --version-major`
  if [ "$MAJOR" = "5" ]; then
    exit 0
  else
    echo "Found an existing Pylon installation in PYLON_ROOT but the version is too low"
    exit 1
  fi
fi

arch="$(uname -m)"
if [ "$arch" == "armv7l" ]; then
  pkgarch="armhf"
elif [ "$arch" == "arm64" ]; then
  pkgarch="arm64"
elif [ "$arch" == "x86_64" ]; then
  pkgarch="amd64"
elif [ "$arch" == "aarch64" ]; then
  pkgarch="arm64"
else
  pkgarch="i386"
fi

version="5.0.11.10914"
pkg=pylon_${version}-deb0_${pkgarch}.deb
url="https://www.baslerweb.com/media/downloads/software/pylon_software/${pkg}"

wget --no-check-certificate -O $pkg $url
sudo dpkg -i $pkg
sudo udevadm control --reload-rules || true
