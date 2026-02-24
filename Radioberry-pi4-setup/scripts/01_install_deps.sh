#!/usr/bin/env bash
set -euo pipefail

sudo apt update
sudo apt install -y \
  git build-essential dkms \
  raspberrypi-kernel-headers \
  fftw3-dev \
  device-tree-compiler \
  gpiod libgpiod2 \
  raspi-gpio \
  net-tools iproute2 \
  usbutils pciutils \
  tcpdump

echo "OK: dependencies installed"
