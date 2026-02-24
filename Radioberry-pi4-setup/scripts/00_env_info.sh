#!/usr/bin/env bash
set -euo pipefail

echo "== System =="
uname -a
echo

echo "== OS =="
sed -n '1,8p' /etc/os-release || true
echo

echo "== Architecture =="
dpkg --print-architecture || true
echo

echo "== Kernel headers =="
if [[ -d "/lib/modules/$(uname -r)/build" ]]; then
  ls -ld "/lib/modules/$(uname -r)/build"
else
  echo "MISSING: /lib/modules/$(uname -r)/build (install raspberrypi-kernel-headers)"
fi
echo

echo "== Boot layout =="
if [[ -d /boot/firmware ]]; then
  echo "Boot dir: /boot/firmware"
else
  echo "Boot dir: /boot"
fi
echo

echo "== IPs =="
ip -br a || true
